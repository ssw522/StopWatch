//
//  FrameToken.swift
//  Receive
//
//  Created by iOS신상우 on 7/24/24.
//

import Foundation


public struct FrameToken {
    public let width: CGFloat?
    public let height: CGFloat?
    
    public init(
        _ width: CGFloat?,
        _ height: CGFloat?
    ) {
        self.width = width
        self.height = height
    }
    
    public init(all: CGFloat?) {
        self.width = all
        self.height = all
    }
}
