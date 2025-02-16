//
//  TodoViewModel.swift
//  StopWatch
//
//  Created by iOS신상우 on 11/23/24.
//

import SwiftUI

class TodoViewModel: ViewModelable {
    private let coordinator: TodoCoordinator
    private let dependency: DependencyBox
    
    @Published var state: State = .init()
    
    init(
        coordinator: TodoCoordinator,
        state: State,
        dependency: DependencyBox = .live
    ) {
        self.coordinator = coordinator
        self.state = state
        self.dependency = dependency
    }
    
    struct State {
        var isExpendedNewTodo: Bool = false
        var isPresentedModalCalendar: Bool = false
        var selectedTodo: Todo?
        var currentDate: Date = .now
        var todoList: [Todo] = []
        var categoryList: [Category] = []
        var categoryName: String = ""
    }
    
    enum Action {
        case fetchDate
        case changeDate(Date?)
        
        case didTapCreateCategory
        case createCategory(name: String)
        case editCategoryName(String)
        
        case didTapStorage
        
        case didTapTodo(Todo)
        case addTodo(Todo)
        case updateTodoDate(Date)
        
        case rightDrag(Todo)
        case leftDrag(Todo)
    }
    
    func reduce(_ action: Action) {
        switch action {
        case .fetchDate:
            let categoryList = try? categoryRepo.getAll()
            state.categoryList = categoryList ?? []
            reduce(.changeDate(state.currentDate))
            
        case .changeDate(let newDate):
            self.state.currentDate = newDate ?? .now
            let todoList = try? todoRepo.getAll()
                .filter { $0.date?.formattedString(by: .yyyyMMdd) == newDate?.formattedString(by: .yyyyMMdd) }
            state.isExpendedNewTodo = false
            state.todoList = todoList ?? []
            
        case .addTodo(let newTodo):
            do {
                try todoRepo.create(entity: newTodo)
                
                if newTodo.date?.formattedString(by: .yyyyMMdd) == state.currentDate.formattedString(by: .yyyyMMdd) {
                    state.todoList.append(newTodo)
                } else if newTodo.date == nil {
                    coordinator.showToast("추가한 Todo가 보관함에 보관되었습니다.")
                }
                
            } catch {
                coordinator.showToast("생성 실패")
            }
            
        case .didTapCreateCategory:
            coordinator.showAlert(
                .init(
                    title: "카테고리 이름 입력",
                    message: .none,
                    inputMessage: Binding(
                        get: { self.state.categoryName },
                        set: { self.state.categoryName = $0 }
                    )
                )
                .addAction(title: "취소", style: .cancel, action: { [weak self] in
                    self?.state.categoryName = ""
                    self?.coordinator.dismiss(animated: false)
                })
                .addAction(title: "추가", style: .primary, action: { [weak self] in
                    self?.coordinator.dismiss(animated: false)
                    self?.reduce(.createCategory(name: self?.state.categoryName ?? ""))
                })
            )
            
        case .createCategory(let name):
            do {
                let newCateogry = Category(name: name)
                try categoryRepo.create(entity: newCateogry)
                state.categoryList.append(newCateogry)
            } catch {
                coordinator.showToast("카테고리 생성 실패")
            }
            
        case .editCategoryName(let name):
            state.categoryName = name
            
        case .didTapStorage:
            state.isExpendedNewTodo = false
            coordinator.setFlow(.storage)
            
        case .didTapTodo(let todo):
            state.isExpendedNewTodo = false
            let viewModel = TodoEditorBottomSheetViewModel(
                coordinator: self.coordinator,
                todo: todo,
                categoryList: state.categoryList,
                delegate: self
            ) { [weak self] in
                self?.state.todoList.removeAll()
                self?.reduce(.fetchDate)
            }
            
            let view = TodoEditorBottomSheetView(viewModel: viewModel).panModal(height: .none)
            
            coordinator.presentPanModals(view)
            
        case .rightDrag(let todo):
            if todo.progress < 1.0 {
                updateProgress(with: todo, to: 1)
            }
            
        case .leftDrag(let todo):
            if todo.progress > 0.0 {
                updateProgress(with: todo, to: 0)
            }
            
        case .updateTodoDate(let newDate):
            
            do {
                if let selectedTodo = state.selectedTodo {
                    try todoRepo.update(
                        entity: selectedTodo,
                        keypaths: [(\.date, newDate)]
                    )
                    
                    coordinator.showToast("'\(selectedTodo.content)'가 \(newDate.formattedString(by: .yyyyMMdd)) 날짜로 변경되었습니다.")
                    
                    reduce(.fetchDate)
                }
                
            } catch {
                coordinator.showToast("업데이트 실패")
            }
            
            state.isPresentedModalCalendar = false
            state.selectedTodo = .none
        }
    }
}

// MARK: - private Method
private extension TodoViewModel {
    func updateProgress(with todo: Todo, to progress: CGFloat) {
        do {
            let percent = "\(Int(progress*100))%"
            
            try todoRepo.update(
                entity: todo,
                keypaths: [(\.progress, progress )]
            )
            
            coordinator.showToast("진행도가 \(percent)로 변경되었습니다.")

            self.state.todoList.removeAll()
            self.reduce(.fetchDate)

        } catch {
            coordinator.showToast("업데이트 실패")
        }
    }
}


// MARK: - UseCase DI
private extension TodoViewModel {
    var todoRepo: any TodoRepository { dependency.resolve() }
    
    var categoryRepo: any CategoryRepository { dependency.resolve() }
}

// MARK: - EditBottomSheetDelegateMethod
extension TodoViewModel: TodoEditorBottomSheetViewModelDelegate {
    func didTapUpdateDate(with todo: Todo) {
        coordinator.dismiss()
        state.isPresentedModalCalendar = true
        state.selectedTodo = todo
    }
}
