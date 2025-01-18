//
//  StopWatchMainViewModel.swift
//  StopWatch
//
//  Created by iOS신상우 on 1/18/25.
//

import Foundation

final class StopWatchMainViewModel: ViewModelable {
    let coordinator: (any CoordinatorType)
    
    @Published var state: State = .init()
    
    init(coordinator: any CoordinatorType, state: State) {
        self.coordinator = coordinator
        self.state = state
    }
    
    struct State {
        
    }
    
    enum Action {
        
    }
    
    func reduce(_ action: Action) {
        
    }
}
