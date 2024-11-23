//
//  PaddingToken.swift
//  Receive
//
//  Created by iOS신상우 on 7/24/24.
//

import Foundation

public struct PaddingToken {
    public var vertical: CGFloat?
    public var horizontal: CGFloat?
    public var top: CGFloat?
    public var bottom: CGFloat?
    public var left: CGFloat?
    public var right: CGFloat?
    
    public init(
        vertical: CGFloat? = .zero,
        horizontal: CGFloat = .zero
    ) {
        self.vertical = vertical
        self.horizontal = horizontal
    }
    
    public init(
        top: CGFloat? = .zero,
        bottom: CGFloat? = .zero,
        left: CGFloat? = .zero,
        right: CGFloat? = .zero
    ) {
        self.top = top
        self.bottom = bottom
        self.left = left
        self.right = right
    }
    
    public init(all: CGFloat) {
        self.vertical = all
        self.horizontal = all
    }
}


