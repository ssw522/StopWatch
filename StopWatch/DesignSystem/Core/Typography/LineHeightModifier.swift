//
//  LineHeightModifier.swift
//  Receive
//
//  Created by iOS신상우 on 7/24/24.
//

import SwiftUI

struct LineHeightModifier: ViewModifier {
    let font: UIFont
    let lineHeight: CGFloat
    
    func body(content: Content) -> some View {
        content
            .lineSpacing(lineHeight - font.lineHeight)
            .padding(.vertical, (lineHeight - font.lineHeight) / 2)
    }
}
