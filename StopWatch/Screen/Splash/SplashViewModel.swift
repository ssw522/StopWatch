//
//  SplashViewModel.swift
//  StopWatch
//
//  Created by iOS신상우 on 11/23/24.
//

import Foundation

final class SplashViewModel: ViewModelable {
    @Published var state: State = .init()
    
    let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    struct State {
        
    }
    
    enum Action {
        case appRoute
    }
    
    func reduce(_ action: Action) {
        switch action {
        case .appRoute:
            Task {
                try? await Task.sleep(for: .seconds(1))
                coordinator.setFlow(.tab)
            }
        }
    }
}

