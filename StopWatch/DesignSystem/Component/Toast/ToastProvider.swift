//
//  ToastProvider.swift
//  Receive
//
//  Created by iOS신상우 on 8/3/24.
//

import SwiftUI

class ToastProvider {
    static let shared = ToastProvider()
    
    private var window: UIWindow?
    private var workItem: DispatchWorkItem?

    private init() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        window = UIWindow(windowScene: windowScene!)
        window?.backgroundColor = .clear
        window?.windowLevel = .alert + 1
        window?.rootViewController = UIHostingController(rootView: EmptyView())
        window?.isUserInteractionEnabled = false
    }

    func show<Content: View>(
        view: Content,
        duration: TimeInterval = .zero
    ) {
        workItem?.cancel()
        workItem = .none
        
        let hosting = UIHostingController(rootView: view)
        hosting.view.backgroundColor = .clear
        window?.rootViewController = hosting
        window?.isHidden = false
        
        if duration != .zero {
            workItem = DispatchWorkItem { [weak self] in
                self?.hide()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: workItem!)
        }
    }

    func hide() {
        window?.isHidden = true
    }
}
