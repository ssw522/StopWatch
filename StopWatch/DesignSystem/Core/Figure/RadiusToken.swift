//
//  RadiusToken.swift
//  Receive
//
//  Created by iOS신상우 on 7/24/24.
//

import Foundation

public struct RadiusToken {
    public var topLeft: CGFloat
    public var bottomLeft: CGFloat
    public var bottomRight: CGFloat
    public var topRight: CGFloat

    public init(
        topLeading: CGFloat = .zero,
        bottomLeading: CGFloat = .zero,
        bottomTrailing: CGFloat = .zero,
        topTrailing: CGFloat = .zero
    ) {
        self.topLeft = topLeading
        self.bottomLeft = bottomLeading
        self.bottomRight = bottomTrailing
        self.topRight = topTrailing
    }
    
    public init(all: CGFloat) {
        self.topLeft = all
        self.bottomLeft = all
        self.bottomRight = all
        self.topRight = all
    }
}
