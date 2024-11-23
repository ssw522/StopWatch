//
//  MainTabCoordinator.swift
//  Receive
//
//  Created by iOS신상우 on 8/2/24.
//

import SwiftUI

enum MainTabParentFlow: ParentFlow {
    
}

final class MainTabCoordinator: CoordinatorType {
    
    var childCoordinators: [any CoordinatorType] = []
    var parentCoordinator: (any CoordinatorType)?
    var navigationController: UINavigationController = .default()
    
    weak var tabViewModel: TabViewModel?
    
    init(parentCoordinator: (any CoordinatorType)? = .none) {
        self.parentCoordinator = parentCoordinator
    }
    
    enum Flow {
        case start
        case changeTab(TabItem)
    }
    
    func setFlow(_ flow: Flow) {
        switch flow {
        case .start:
            let viewModel = TabViewModel(coordinator: self)
            tabViewModel = viewModel
            let view = MainTabView(viewModel: viewModel).viewController
            self.navigationController.setViewControllers([view], animated: false)
        
        case .changeTab(let newTab):
            tabViewModel?.state.currentTab = newTab
        }
    }
    
    func setParentFlow(_ flow: any ParentFlow) {
//        guard let flow = flow as? MainTabParentFlow else {
//            return
//        }
//        
//        switch flow {
//        case .logout:
//        }
    }
}

extension MainTabCoordinator {

}
