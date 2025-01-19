//
//  SettingCoordinator.swift
//  StopWatch
//
//  Created by iOS신상우 on 1/18/25.
//

import SwiftUI

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
        }
    }
    
    enum Flow {
        case feedBack
    }
    
    
    
    func setParentFlow(_ flow: any ParentFlow) {
        
    }
}
