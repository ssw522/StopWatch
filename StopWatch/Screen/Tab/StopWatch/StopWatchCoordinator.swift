//
//  StopWatchCoordinator.swift
//  StopWatch
//
//  Created by iOS신상우 on 2/1/25.
//

import UIKit.UINavigationController

final class StopWatchCoordinator: CoordinatorType {
    var navigationController: UINavigationController
    var parentCoordinator: (any CoordinatorType)?
    var childCoordinators: [any CoordinatorType] = []
    
    init(
        navigationController: UINavigationController,
        parentCoordinator: (any CoordinatorType)? = nil
    ) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    enum Flow {
        
    }
    
    func setFlow(_ flow: Flow) {
        
    }
    
    func setParentFlow(_ flow: any ParentFlow) {
        
    }
}
