//
//  PreffixModifier.swift
//  Receive
//
//  Created by iOS신상우 on 7/28/24.
//

import SwiftUI

public struct PrefixModifier<Prefix: View>: ViewModifier {
    @ViewBuilder var prefix: (() -> Prefix)
    
    public func body(content: Content) -> some View {
        return content.overlay {
            HStack {
                prefix()
                Spacer()
            }
        }
    }
}
