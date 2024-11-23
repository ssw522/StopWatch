//
//  NavigationController.swift
//  Receive
//
//  Created by iOS신상우 on 7/28/24.
//

import UIKit.UINavigationController

public extension UINavigationController {
    static func `default`() -> UINavigationController {
        let nController = UINavigationController()
        nController.isNavigationBarHidden = true
        nController.modalPresentationStyle = .fullScreen
        return nController
    }
}


// MARK: - 네비게이션 back제스쳐 활성화
extension UINavigationController: @retroactive UINavigationControllerDelegate, @retroactive UIGestureRecognizerDelegate {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

