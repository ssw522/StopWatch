//
//  TodoViewModel.swift
//  StopWatch
//
//  Created by iOS신상우 on 11/23/24.
//

import SwiftUI

class TodoViewModel: ViewModelable {
    private let coordinator: (any CoordinatorType)
    
    @Published var state: State = .init()
    
    init(coordinator: any CoordinatorType, state: State) {
        self.coordinator = coordinator
        self.state = state
    }
    
    struct State {
        var currentDate: Date = .now
        var newContent: String = ""
    }
    
    enum Action {
        case editNewTodoContent(String)
        case changeDate(Date?)
    }
    
    func reduce(_ action: Action) {
        switch action {
        case .editNewTodoContent(let newContent):
            state.newContent = newContent
            
        case .changeDate(let newDate):
            self.state.currentDate = newDate ?? .now
        }
    }
}
