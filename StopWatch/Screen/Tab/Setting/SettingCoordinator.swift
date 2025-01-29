//
//  SettingCoordinator.swift
//  StopWatch
//
//  Created by iOS신상우 on 1/18/25.
//

import SwiftUI

enum SettingParentFlow: ParentFlow {
    case didFinishPop
}

final class SettingCoordinator: CoordinatorType {
    
    var childCoordinators: [any CoordinatorType] = []
    var parentCoordinator: (any CoordinatorType)?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, parentCoordinator: (any CoordinatorType)?) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func setFlow(_ flow: Flow) {
        switch flow {
        case .feedBack:
            let viewModel = FeedBackViewModel(coordinator: self, state: .init())
            let view = FeedBackView(viewModel: viewModel).viewController
            
            push(view)
            
        case .categoryList:
            let coordinator = CategoryCoordinator(navigationController: navigationController, parentCoordinator: self)
            childCoordinators.append(coordinator)
            coordinator.setFlow(.categoryList)
        }
    }
    
    enum Flow {
        case feedBack
        case categoryList
    }
    
    
    
    func setParentFlow(_ flow: any ParentFlow) {
        guard let parentFlow = flow as? SettingParentFlow else {
            return
        }
        
        switch parentFlow {
        case .didFinishPop:
            pop()
            childCoordinators = []
        }
    }
}
