//
//  CategoryCoordinator.swift
//  StopWatch
//
//  Created by iOS신상우 on 1/22/25.
//

import UIKit.UINavigationController

final class CategoryCoordinator: CoordinatorType {
    var parentCoordinator: (any CoordinatorType)?
    var childCoordinators: [any CoordinatorType] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, parentCoordinator: (any CoordinatorType)?) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    enum Flow {
        case categoryList
        case finish
    }
    
    func setParentFlow(_ flow: any ParentFlow) {
        
    }
    
    func setFlow(_ flow: Flow) {
        switch flow {
        case .categoryList:
            let viewModel = CategoryListViewModel(coordinator: self)
            let view = CategoryListView(viewModel: viewModel).viewController
            
            push(view)
            
        case .finish:
            parentCoordinator?.setParentFlow(SettingParentFlow.didFinishPop)
        }
    }
}
