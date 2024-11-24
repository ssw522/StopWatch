//
//  TodoCell.swift
//  StopWatch
//
//  Created by iOS신상우 on 11/24/24.
//

import SwiftUI

struct TodoCell: View {
    var category: String
    var content: String
    var date: Date?
    var state: CheckImage
    
    var body: some View {
        HStack(spacing: .zero) {
            VStack(alignment: .leading, spacing: 2) {
                Text(category)
                    .setTypo(.caption1)
                Text(content)
                    .setTypo(.label1)
                if let date {
                    HStack(spacing: 4) {
                        Image(systemName: "clock").renderingMode(.template)
                            .resizable()
                            .frame(width: 12, height: 12)
                        Text(date.formattedString(by: .ahhmm))
                            .setTypo(.caption1)
                    }
                }
            }
            
            Spacer()
            CircleProgressView(value: 0.4, style: .xs)
        }
        .foregroundStyle(Color.white)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .padding(.bottom, 12)
        .padding(.top, 8)
        .background(Color.gray)
        .clipShape(.rect(cornerRadius: 12))
    }
}
