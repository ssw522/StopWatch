//
//  TodoCell.swift
//  StopWatch
//
//  Created by iOS신상우 on 11/24/24.
//

import SwiftUI

struct TodoCell: View {
    let todo: Todo
    
    var body: some View {
        HStack(spacing: .zero) {
            VStack(alignment: .leading, spacing: 2) {
                if let category = todo.category {
                    Text(category.name)
                        .setTypo(.caption1)
                        .foregroundStyle(Color.getColor(.text_alternative))
                }
                
                Text(todo.content)
                    .setTypo(.label1)
                    .overlay {
                        GeometryReader { reader in
                            Rectangle()
                                .fill(Color.getColor(.gray_text))
                                .offset(y: reader.size.height/2)
                                .frame(
                                    width: todo.progress == 1 ? reader.size.width : 0,
                                    height: 1
                                )
                        }
                    }
            }
            
            Spacer()
            CircleProgressView(value: todo.progress, size: .xs)
        }
        .foregroundStyle(Color.getColor(.text_normal))
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .padding(.bottom, 12)
        .padding(.top, 8)
        .background(Color.getColor(.background_primary))
        .clipShape(.rect(cornerRadius: 12))
        .animation(.easeInOut(duration: 2.0), value: todo.progress)
    }
}
