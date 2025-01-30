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
        var currentDate: Date = .now
        var newContent: String = ""
        var todoList: [Todo] = []
        var categoryList: [Category] = []
        var categoryName: String = ""
    }
    
    enum Action {
        case fetchDate
        case editNewTodoContent(String)
        case changeDate(Date?)
        case addTodo(Todo)
        case didTapCreateCategory
        case createCategory(name: String)
        case editCategoryName(String)
        case didTapStorage
    }
    
    func reduce(_ action: Action) {
        switch action {
        case .fetchDate:
            let categoryList = try? categoryRepo.getAll()
            state.categoryList = categoryList ?? []
            reduce(.changeDate(state.currentDate))
            
        case .editNewTodoContent(let newContent):
            state.newContent = newContent
            
        case .changeDate(let newDate):
            self.state.currentDate = newDate ?? .now
            let todoList = try? todoRepo.getAll()
                .filter { $0.date?.formattedString(by: .yyyyMMdd) == newDate?.formattedString(by: .yyyyMMdd) }
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
                        set: { self.reduce(.editCategoryName($0)) }
                    )
                )
                .addAction(title: "취소", style: .cancel, action: { [weak self] in
                    self?.state.categoryName = ""
                    self?.coordinator.dismiss()
                })
                .addAction(title: "추가", style: .primary, action: { [weak self] in
                    self?.coordinator.dismiss()
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
            coordinator.setFlow(.storage)
        }
    }
}

// MARK: - UseCase DI
private extension TodoViewModel {
    var todoRepo: any TodoRepository { dependency.resolve() }
    
    var categoryRepo: any CategoryRepository { dependency.resolve() }
}
