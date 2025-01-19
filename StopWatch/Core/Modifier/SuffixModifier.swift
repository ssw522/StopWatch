//
//  SuffixModifier.swift
//  Receive
//
//  Created by iOS신상우 on 7/28/24.
//

import SwiftUI

public struct SuffixModifier<Suffix: View>: ViewModifier {
    @ViewBuilder var suffix: (() -> Suffix)
    
    public func body(content: Content) -> some View {
        return content.overlay {
            HStack {
                Spacer()
                suffix()
            }
        }
    }
}
