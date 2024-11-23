//
//  ViewWrapper.swift
//  Receive
//
//  Created by iOS신상우 on 7/28/24.
//

import SwiftUI

public class ViewWrapper<Content: View>: UIHostingController<Content> {
    
    public init(
        backgroundColor: UIColor = .systemBackground,
        @ViewBuilder content: () -> Content)
    {
        super.init(rootView: content())
        self.view.backgroundColor = backgroundColor
        self.modalPresentationStyle = .fullScreen
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

