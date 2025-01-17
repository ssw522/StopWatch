//
//  SWCalendarCell.swift
//  StopWatch
//
//  Created by iOS신상우 on 11/26/24.
//

import SwiftUI

struct SWCalendarCell: View {
    var day: Int
    var clicked: Bool
    var isToday: Bool
    
    var textColor: Color {
        return Color.black
    }
    
    var backgroundColor: Color {
        return Color.white
    }
    
    init(
        day: Int,
        clicked: Bool = false,
        isToday: Bool = false
    ) {
        self.day = day
        self.clicked = clicked
        self.isToday = isToday
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            Text("\(day)")
                .setTypo(.label2)
                .foregroundStyle(textColor)
            Spacer()
        }
        .frame(height: 56)
    }
}

