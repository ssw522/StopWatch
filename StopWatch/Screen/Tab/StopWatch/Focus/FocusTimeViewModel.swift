//
//  FocusTimeViewModel.swift
//  StopWatch
//
//  Created by iOS신상우 on 2/2/25.
//

import Foundation

protocol FocusTimeViewModelDelegate: AnyObject {
    func saveTimeCheck(with timeCheck: TimeCheck)
}

final class FocusTimeViewModel: ViewModelable {
    private let coordinator: StopWatchCoordinator
    private let dependency: DependencyBox
    
    @Published var state: State
    
    weak var delegate: FocusTimeViewModelDelegate?
    
    init(
        coordinator: StopWatchCoordinator,
        dependency: DependencyBox = .live,
        focusMode: FocusMode = .motion,
        state: State,
        delegate: FocusTimeViewModelDelegate?
    ) {
        self.coordinator = coordinator
        self.dependency = dependency
        self.state = state
        self.delegate = delegate
    }
    
    struct State {
        var startDate: Date
        var endDate: Date? = .none
        var breakTime: CGFloat = .zero
        var todayTodoList: [Todo] = []
        var selectedTodo: Todo?
        var isFocusing: Bool = false
    }
    
    enum Action {
        case onAppear
        case didTapTodo(Todo)
        case didTapSave
    }
    
    func reduce(_ action: Action) {
        switch action {
            
        case .onAppear:
            let allTodo = try? todoRepo.getAll()
            state.todayTodoList = allTodo?.filter {
                $0.date?.formattedString(by: .yyyyMMdd) == Date.now.formattedString(by: .yyyyMMdd)
            } ?? []
            
        case .didTapTodo(let todo):
            state.selectedTodo = todo
        
        case .didTapSave:
            if let selectedTodo = state.selectedTodo {
                delegate?.saveTimeCheck(
                    with: .init(
                        startDate: state.startDate,
                        endDate: state.endDate ?? .now,
                        breakTime: state.breakTime,
                        todo: selectedTodo)
                )
            }
        }
    }
    
    enum FocusMode {
        case manual
        case motion
    }
}

private extension FocusTimeViewModel {
    var todoRepo: any TodoRepository {
        dependency.resolve()
    }
}
