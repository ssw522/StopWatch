//
//  SettingViewModel.swift
//  StopWatch
//
//  Created by iOS신상우 on 1/18/25.
//

import Foundation

final class SettingViewModel: ViewModelable {
    let coordinator: SettingCoordinator
    
    @Published var state: State = .init()
    
    init(coordinator: SettingCoordinator, state: State) {
        self.coordinator = coordinator
        self.state = state
    }
    
    struct State {
        
    }
    
    enum Action {
        case notificationSetting
        case feedback
    }
    
    func reduce(_ action: Action) {
        switch action {
        case .notificationSetting:
            coordinator.showToast("추후 지원 예정인 기능입니다.")
        
        case .feedback:
                break
        }
    }
}
