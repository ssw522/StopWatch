//
//  TimeHistoryCell.swift
//  StopWatch
//
//  Created by iOS신상우 on 1/18/25.
//

import SwiftUI

struct TimeHistoryCell: View {
    let date: Date
    let todo: String
    let todoTime: String
    
    var body: some View {
        HStack(spacing: .zero) {
            Text(date.formattedString(by: .yyyyMMddHHmm))
                .setTypo(.caption1)
                .foregroundStyle(Color.getColor(.text_assistive))
            FixedSpacer(12)
            Text(todo)
                .setTypo(.label2)
                .foregroundStyle(Color.getColor(.text_alternative))
            Spacer()
            Text(todoTime)
                .setTypo(.label2)
        }
    }
}
