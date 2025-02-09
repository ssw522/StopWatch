//
//  TodoEditorBottomSheetViewModel.swift
//  StopWatch
//
//  Created by iOS신상우 on 1/31/25.
//

import Foundation

protocol TodoEditorBottomSheetViewModelDelegate: AnyObject {
    func didTapUpdateDate(with todo: Todo)
}

final class TodoEditorBottomSheetViewModel: ViewModelable {
    let coordinator: any CoordinatorType
    
    let todo: Todo
    let categoryList: [Category]
    let updateTodoListHandler: (()->Void)?
    
    private let dependency: DependencyBox
    weak var delegate: TodoEditorBottomSheetViewModelDelegate?
    
    @Published var state: State
    
    init(
        coordinator: any CoordinatorType,
        dependency: DependencyBox = .live,
        todo: Todo,
        categoryList: [Category],
        delegate: TodoEditorBottomSheetViewModelDelegate?,
        updateTodoListHandler: (()->Void)?
    ) {
        self.coordinator = coordinator
        self.dependency = dependency
        self.todo = todo
        self.categoryList = categoryList
        self.state = .init(progress: todo.progress)
        self.updateTodoListHandler = updateTodoListHandler
        self.delegate = delegate
    }
    
    struct State {
        var progress: CGFloat = .zero
    }
    
    enum Action {
        case didTapDelete
        case didTapUpdateCategory(Category)
        case didTapUpdateDate
        case didTapNotificationSetting
        case changeProgress(CGFloat)
        case updateProgress(CGFloat)
        case archive
    }
    
    func reduce(_ action: Action) {
        switch action {
            
        case .didTapDelete:
            do {
                let content = todo.content
                try todoRepo.delete(entity: todo)
                coordinator.showToast("'\(content)'가 삭제되었습니다.")
                coordinator.dismiss()
                updateTodoListHandler?()
                
            } catch {
                coordinator.showToast("삭제 실패")
            }
            
        case .didTapUpdateCategory(let category):
            do {
                try todoRepo.update(
                    entity: todo,
                    keypaths: [(\.category, category )]
                )
                
                coordinator.showToast("'\(todo.content)'가 \(category.name)으로 변경되었습니다.")
                coordinator.dismiss()
                updateTodoListHandler?()
            } catch {
                coordinator.showToast("업데이트 실패")
            }
        
        case .didTapUpdateDate:
            delegate?.didTapUpdateDate(with: todo)
            
        case .didTapNotificationSetting:
            coordinator.showToast("추후 지원 예정인 기능입니다.")
            
        case .changeProgress(let progress):
            state.progress = progress
            
        case .updateProgress(let progress):
            do {
                try todoRepo.update(
                    entity: todo,
                    keypaths: [(\.progress, progress )]
                )
                let percent = "\(Int(progress*100))%"
                coordinator.showToast("진행도가 \(percent)로 변경되었습니다.")
                updateTodoListHandler?()
            } catch {
                coordinator.showToast("업데이트 실패")
            }
            
        case .archive:
            do {
                try todoRepo.update(
                    entity: todo,
                    keypaths: [(\.date, .none )]
                )
                coordinator.showToast("'\(todo.content)'가 보관함에 보관되었습니다.")
                coordinator.dismiss()
                updateTodoListHandler?()
            } catch {
                coordinator.showToast("보관 실패")
            }
        }
    }
}

private extension TodoEditorBottomSheetViewModel {
    var todoRepo: any TodoRepository {
        dependency.resolve()
    }
}
