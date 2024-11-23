//
//  CoordinatorType.swift
//  Receive
//
//  Created by iOS신상우 on 7/28/24.
//

import SwiftUI

public protocol ParentFlow { }

public protocol CoordinatorType {
    associatedtype Flow
    
    var childCoordinators: [any CoordinatorType] { get }
    var parentCoordinator: (any CoordinatorType)? { get set }
    
    var navigationController: UINavigationController { get }
    
    func setFlow(_ flow: Flow)
    func setParentFlow(_ flow: any ParentFlow)
}
