//
//  CoordinatorType+.swift
//  Receive
//
//  Created by iOS신상우 on 9/7/24.
//

import UIKit

// MARK: - Default Implement
extension CoordinatorType {
    
    func present(
        _ viewcontroller: UIViewController,
        style: UIModalPresentationStyle = .fullScreen,
        animated: Bool = true
    ) {
        viewcontroller.modalPresentationStyle = style
        navigationController.present(viewcontroller, animated: animated)
    }
    
//    func presentPanModals(_ viewController: PanModalPresentable.LayoutType) {
//        navigationController.presentPanModal(viewController)
//    }
    
    func dismiss(animated: Bool = true, completion: (()->Void)? = .none) {
        navigationController.dismiss(animated: animated) { completion?() }
    }
    
    func pop(_ animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
    
    func push(
        _ viewcontroller: UIViewController,
        animated: Bool = true
    ) {
        navigationController.pushViewController(viewcontroller, animated: animated)
    }
    
    func showToast(_ message: String, duration: Double = 2.0) {
        let toastView = ToastView(message: message, duration: duration)
        ToastProvider.shared.show(view: toastView, duration: duration)
    }
    
    func showAlert(_ alert: StopWatchAlertView) {
        present(alert.viewControllerClear, style: .overFullScreen, animated: false)
    }
    
    func changeTab(tab: TabItem) {
//        if let tabCoordinator = AppCoordinator.shared.childCoordinators.first(where: { $0 is MainTabCoordinator }) as? MainTabCoordinator {
//            tabCoordinator.setFlow(.changeTab(tab))
//        }
    }
}
