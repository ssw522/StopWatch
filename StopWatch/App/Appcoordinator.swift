//
//  Appcoordinator.swift
//  StopWatch
//
//  Created by iOS신상우 on 11/23/24.
//

import UIKit

enum AppCoordinatorParentFlow: ParentFlow {
}


final class AppCoordinator: CoordinatorType {
    
    static let shared = AppCoordinator()
    
    var navigationController: UINavigationController = .default()
    
    var childCoordinators: [any CoordinatorType] = []
    
    var parentCoordinator: (any CoordinatorType)? = .none
    
    private init() {
        setFlow(.splash)
    }
    
    enum Flow {
        case splash
        case tab
    }
    
    func setFlow(_ flow: Flow) {
        switch flow {
        case .splash:
            let viewModel = SplashViewModel(coordinator: self)
            let view = SplashView(viewModel: viewModel).viewController
            navigationController.viewControllers = [view]
            
        case .tab:
            let coordinator = MainTabCoordinator(parentCoordinator: self)
            childCoordinators.append(coordinator)
            coordinator.setFlow(.start)
            present(coordinator.navigationController)
        }
    }
}

// MARK: - ParentFlow
extension AppCoordinator {
    func setParentFlow(_ flow: any ParentFlow) {
//        guard let flow = flow as? AppCoordinatorParentFlow else {
//            return
//        }
//        
//        switch flow {
//        
//        }
    }
}
