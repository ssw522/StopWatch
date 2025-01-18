//
//  TabViewModel.swift
//  Receive
//
//  Created by iOS신상우 on 7/29/24.
//

import Foundation

final class TabViewModel: ViewModelable {
    let coordinator: MainTabCoordinator
    
    @Published var state: State = .init()
    
    init(coordinator: MainTabCoordinator) {
        self.coordinator = coordinator
    }
    
    struct State {
        var currentTab: TabItem = .todo
    }
    
    enum Action {
        case didSelectTab(TabItem)
        case onAppear
    }
    
    
    // MARK: - Child ViewModels
    
    lazy var todoViewModel: TodoViewModel = {
        let coordinator = TodoCoordinator(
            navigationController: coordinator.navigationController,
            parentCoordinator: coordinator
        )
        self.coordinator.childCoordinators.append(coordinator)
        return .init(coordinator: coordinator, state: .init())
    }()
//    
//    lazy var policyViewModel: PolicyViewModel = {
//        let coordinator = PolicyCoordinator(
//            navigationController: coordinator.navigationController,
//            parentCoordinator: self.coordinator
//        )
//        self.coordinator.childCoordinators.append(coordinator)
//        return .init(coordinator: coordinator)
//    }()
//
//    lazy var feedViewModel: FeedViewModel = {
//        let coordinator = FeedCoordinator(
//            navigationController: coordinator.navigationController,
//            parentCoordinator: self.coordinator
//        )
//        self.coordinator.childCoordinators.append(coordinator)
//        return .init(coordinator: coordinator)
//    }()
//    
    lazy var settingViewModel: SettingViewModel = {
        let coordinator = SettingCoordinator(
            navigationController: coordinator.navigationController,
            parentCoordinator: coordinator)
        self.coordinator.childCoordinators.append(coordinator)
        return .init(coordinator: coordinator, state: .init())
    }()
    
    func reduce(_ action: Action) {
        switch action {
        case .onAppear:
            break
        case .didSelectTab(let tab):
            state.currentTab = tab
        }
    }
}
