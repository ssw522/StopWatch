//
//  TodoCell.swift
//  StopWatch
//
//  Created by iOS신상우 on 11/24/24.
//

import SwiftUI

struct TodoCell: View {
    let todo: Todo
    var state: CheckImage
    
    var body: some View {
        HStack(spacing: .zero) {
            VStack(alignment: .leading, spacing: 2) {
                Text(todo.category?.name ?? "")
                    .setTypo(.caption1)
                    .foregroundStyle(Color.getColor(.text_alternative))
                Text(todo.content)
                    .setTypo(.label1)
                if let date = todo.date {
                    HStack(spacing: 4) {
                        Image(systemName: "clock").renderingMode(.template)
                            .resizable()
                            .frame(width: 12, height: 12)
                        Text(date.formattedString(by: .ahhmm))
                            .setTypo(.caption1)
                    }
                    .foregroundStyle(Color.getColor(.text_assistive))
                }
            }
            
            Spacer()
//            CircleProgressView(value: 0.4, size: .xs)
        }
        .foregroundStyle(Color.getColor(.text_normal))
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .padding(.bottom, 12)
        .padding(.top, 8)
        .background(Color.getColor(.background_primary))
        .clipShape(.rect(cornerRadius: 12))
    }
}
