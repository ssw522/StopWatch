//
//  TitleView.swift
//  Receive
//
//  Created by iOS신상우 on 8/4/24.
//

import SwiftUI

struct TitleView: View {
    let title: String
    let content: String?
    
    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .hSpacing(alignment: .leading)
                .setTypo(.subTitle1)
                .foregroundStyle(Color.getColor(.text_strong))
            if let content {
                Text(content)
                    .hSpacing(alignment: .leading)
                    .setTypo(.body1)
                    .foregroundStyle(Color.getColor(.text_alternative))
            }
        }
    }
}
