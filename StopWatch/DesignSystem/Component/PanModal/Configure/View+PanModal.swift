//
//  View+.swift
//  Receive
//
//  Created by iOS신상우 on 8/6/24.
//

import SwiftUI

public extension View {
    func panModal(
        minHeight: CGFloat? = 552,
        maxHeight: CGFloat? = 552,
        radius: CGFloat = 24
    ) -> PanModalWrapper<Self> {
        PanModalWrapper(
            minHeight: minHeight,
            maxHeight: maxHeight,
            radius: radius
        ) {
            self
        }
    }
    
    func panModal(
        height: CGFloat? = 552,
        radius: CGFloat = 24
    ) -> PanModalWrapper<Self> {
        PanModalWrapper(
            minHeight: height,
            maxHeight: height,
            radius: radius
        ) {
            self
        }
    }
}
