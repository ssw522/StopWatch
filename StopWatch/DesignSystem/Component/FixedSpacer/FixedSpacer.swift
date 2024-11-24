//
//  FixedSpacer.swift
//  Receive
//
//  Created by iOS신상우 on 7/27/24.
//

import SwiftUI

public struct FixedSpacer: View {
    var size: CGFloat
    
    public init(_ size: CGFloat) {
        self.size = size
    }
    
    public var body: some View {
        Spacer()
            .frame(width: size, height: size)
    }
}
