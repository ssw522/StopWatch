//
//  TodoEditorBottomSheetViewModel.swift
//  StopWatch
//
//  Created by iOS신상우 on 1/31/25.
//

import Foundation

final class TodoEditorBottomSheetViewModel: ViewModelable {
    let coordinator: any CoordinatorType
    
    let todo: Todo
    let updateTodoListHandler: (()->Void)?
    
    private let dependency: DependencyBox
    
    @Published var state: State
    
    init(
        coordinator: any CoordinatorType,
        dependency: DependencyBox = .live,
        todo: Todo,
        state: State = .init(),
        updateTodoListHandler: (()->Void)?
    ) {
        self.coordinator = coordinator
        self.dependency = dependency
        self.todo = todo
        self.state = state
        self.updateTodoListHandler = updateTodoListHandler
    }
    
    struct State {
        var progress: CGFloat = 0
        var isPresentedCalendarModal: Bool = false
    }
    
    enum Action {
        case didTapDelete
        case didTapUpdateCategory
        case didTapUpdateDate
        case didTapNotificationSetting
        case changeProgress(CGFloat)
        case updateDate(Date)
    }
    
    func reduce(_ action: Action) {
        switch action {
            
        case .didTapDelete:
            break
        case .didTapUpdateCategory:
            break
        
        case .didTapUpdateDate:
            state.isPresentedCalendarModal = true
            
        case .didTapNotificationSetting:
            coordinator.showToast("추후 지원 예정인 기능입니다.")
            
        case .changeProgress(let progress):
            state.progress = progress
            
        case .updateDate(let date):
            do {
                try todoRepo.update(
                    entity: todo,
                    keypaths: [(\.date, date )]
                )
                
                coordinator.showToast("'\(todo.content)'가 \(date.formattedString(by: .yyyyMMdd)) 날짜로 변경되었습니다.")
                coordinator.dismiss()
                updateTodoListHandler?()
            } catch {
                coordinator.showToast("업데이트 실패")
            }
        }
    }
}

private extension TodoEditorBottomSheetViewModel {
    var todoRepo: any TodoRepository {
        dependency.resolve()
    }
}
