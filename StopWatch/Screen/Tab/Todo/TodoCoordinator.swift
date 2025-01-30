//
//  TodoCoordinator.swift
//  StopWatch
//
//  Created by iOS신상우 on 1/18/25.
//

import SwiftUI

final class TodoCoordinator: CoordinatorType {
    
    var childCoordinators: [any CoordinatorType] = []
    var parentCoordinator: (any CoordinatorType)?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, parentCoordinator: (any CoordinatorType)?) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func setFlow(_ flow: Flow) {
        switch flow {
        case .storage:
            let viewModel = TodoStorageViewModel(coordinator: self, state: .init())
            let view = TodoStorageView(viewModel: viewModel).viewController
            
            push(view)
        }
    }
    
    enum Flow {
        case storage
    }
    
    func setParentFlow(_ flow: any ParentFlow) {
        
    }
}
