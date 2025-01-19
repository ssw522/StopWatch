//
//  View+Modifier.swift
//  Receive
//
//  Created by iOS신상우 on 7/28/24.
//

import SwiftUI

public extension View {
    func suffix<Suffix: View>(@ViewBuilder _ suffix: (() -> Suffix)) -> some View {
        self.overlay {
            HStack {
                Spacer()
                suffix()
            }
        }
    }
    
    func prefix<Prefix: View>(@ViewBuilder _ prefix: (() -> Prefix)) -> some View {
        self.overlay {
            HStack {
                prefix()
                Spacer()
            }
        }
    }
}
