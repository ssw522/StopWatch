//
//  PanModalWrapper.swift
//  Receive
//
//  Created by iOS신상우 on 8/6/24.
//

import SwiftUI

public class PanModalWrapper<Content: View>: UIHostingController<Content> {
    
    private let minHeight: CGFloat?
    private let maxHeight: CGFloat?
    private let radius: CGFloat
    
    public init(
        minHeight: CGFloat?,
        maxHeight: CGFloat?,
        backgroundColor: UIColor = .white,
        radius: CGFloat,
        @ViewBuilder content: () -> Content)
    {
        self.minHeight = minHeight
        self.maxHeight = maxHeight
        self.radius = radius
        super.init(rootView: content())
        self.view.backgroundColor = backgroundColor
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PanModalWrapper: PanModalPresentable {
    public var panScrollable: UIScrollView? {
        .none
    }
     
    public var shortFormHeight: PanModalHeight {
        if let minHeight {
            .contentHeight(minHeight)
        } else {
            .intrinsicHeight
        }
    }
    
    public var longFormHeight: PanModalHeight {
        if let maxHeight {
            .contentHeight(maxHeight)
        } else {
            .intrinsicHeight
        }
    }
    
    public var showDragIndicator: Bool {
        false
    }
    
    public var springDamping: CGFloat {
        1.0
    }
    
    public var cornerRadius: CGFloat {
        radius
    }
}
