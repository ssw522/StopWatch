//
//  TodoStorageViewModel.swift
//  StopWatch
//
//  Created by iOS신상우 on 1/29/25.
//

import Foundation

class TodoStorageViewModel: ViewModelable {
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
        var isEditMode: Bool = false
        var todoList: [Todo] = []
        var selectedList: [Todo] = []
        var isPresentedModalCalendar: Bool = false
        var changeDate: Date = .now
    }
    
    enum Action {
        case pop
        case changeEditMode
        case fetchData
        case didTapTodo(Todo)
        case selectTodo(Todo)
        case delete
        case exportTodo
        case changeDate(Date)
    }
    
    func reduce(_ action: Action) {
        switch action {
        case .fetchData:
            let todoList = try? todoRepo.getAll().filter { $0.date == nil }
            state.todoList = todoList ?? []
            
        case .pop:
            coordinator.pop()
            
        case .changeEditMode:
            state.isEditMode.toggle()
            state.selectedList = []
            
        case .didTapTodo(_):
            break
            
        case .selectTodo(let todo):
            if let index = state.selectedList.firstIndex(of: todo) {
                state.selectedList.remove(at: index)
            } else {
                state.selectedList.append(todo)
            }
            
        case .delete:
            do {
                let count = state.selectedList.count
                try todoRepo.delete(entities: state.selectedList)
                state.todoList.removeAll { state.selectedList.contains($0) }
                reduce(.changeEditMode)
                coordinator.showToast("\(count)개의 Todo가 보관함에서 삭제되었어요!")
            } catch {
                coordinator.showToast("Todo 삭제 실패")
            }
            
        case .exportTodo:
            state.isPresentedModalCalendar = true
            
        case .changeDate(let date):
            guard state.isPresentedModalCalendar else {
                return
            }
            
            do {
                try todoRepo.update(
                    entities: state.selectedList,
                    keypaths: [
                        (\.date, date)
                    ]
                )
                
                state.todoList.removeAll { state.selectedList.contains($0) }
                reduce(.changeEditMode)
                state.isPresentedModalCalendar = false
                state.changeDate = .now
                
                coordinator.showToast("\(date.formattedString(by: .yyyyMMdd))날짜에 추가되었어요!")
            } catch {
                coordinator.showToast("Todo 내보내기 실패")
            }
        }
    }
}

// MARK: - UseCase DI
private extension TodoStorageViewModel {
    var todoRepo: any TodoRepository { dependency.resolve() }
}
