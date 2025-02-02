//
//  TodoStorageCell.swift
//  StopWatch
//
//  Created by iOS신상우 on 1/30/25.
//

import SwiftUI

struct TodoStorageCell: View {
    let todo: Todo
    var isEditMode: Bool = false
    var isSelected: Bool = false
    
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
            }
            
            Spacer()
            if isEditMode {
                Image(isSelected ? .checkFillOn : .checkFillOff)
            }
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
