//
//  SWCalendarView.swift
//  StopWatch
//
//  Created by iOS신상우 on 11/25/24.
//

import SwiftUI

struct SWCalendarView: View {
    private let clendarService: CalendarService = CalendarService()
    
    @State var displayDate: Date
    @State var selectedDate: Date
    
    var today: Date = .now
    
    var body: some View {
        VStack(spacing: .zero) {
            weekdaysSymbolsView
            TabView {
                calendarGridView(date: previousMonthDate)
                calendarGridView(date: displayDate)
                calendarGridView(date: nextMonthDate)
            }
            .tabViewStyle(.page)
            .frame(height: 380)
            
//            ScrollView(.horizontal) {
//                HStack(spacing: .zero) {
//                    ForEach([previousMonthDate, displayDate, nextMonthDate], id: \.self) { date in
//                        calendarGridView(date: date)
//                    }
//                }
//                .scrollTargetLayout()
//            }
//            .scrollTargetBehavior(.viewAligned)
        }
    }
}

private extension SWCalendarView {
    var previousMonthDate: Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .month, value: -1, to: displayDate) ?? displayDate
    }
    
    var nextMonthDate: Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .month, value: 1, to: displayDate) ?? displayDate
    }
    
    func isToday(_ compareDate: Date) -> Bool {
        return Date.now.formattedString(by: .yyyyMMdd) == compareDate.formattedString(by: .yyyyMMdd)
    }
    
    static let weekdaySymbols: [String] = ["일","월","화","수","목","금","토"]
    
    var weekdaysSymbolsView: some View {
        HStack(spacing: .zero) {
            ForEach(Self.weekdaySymbols.indices, id: \.self) { symbol in
                Text(Self.weekdaySymbols[symbol].uppercased())
                    .foregroundColor(Color.getColor(.text_assistive))
                    .setTypo(.label3)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.bottom, 5)
    }
    
    func calendarGridView(date: Date) -> some View {
        let daysInMonth: Int = clendarService.numberOfDays(in: date)
        let firstWeekday: Int = clendarService.firstWeekdayOfMonth(in: date) - 1
        let lastDayOfMonthBefore = clendarService.numberOfDays(in: clendarService.previousMonth(date: date))
        let numberOfRows = Int(ceil(Double(daysInMonth + firstWeekday) / 7.0))
        let visibleDaysOfNextMonth = numberOfRows * 7 - (daysInMonth + firstWeekday)
        
        return LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
            ForEach(-firstWeekday ..< daysInMonth + visibleDaysOfNextMonth, id: \.self) { index in
                Group {
                    if index > -1 && index < daysInMonth {
                        let date = clendarService.getDate(for: index, date: date)
                        let day = Calendar.current.component(.day, from: date)
                        let isToday = isToday(date)
                        SWCalendarCell(day: day, clicked: false, isToday: isToday)
                        
                    } else if let _ = Calendar.current.date(
                        byAdding: .day,
                        value: index + lastDayOfMonthBefore,
                        to: clendarService.previousMonth(date: date)
                    ) {
                        // TODO: 이전, 이후 달의 일 표시 하고 싶으면 여기
                        Color.clear
                            .frame(height: 56)
                    }
                }
                .onTapGesture {
                    if 0 <= index && index < daysInMonth {
                        //                        let date = getDate(for: index)
                        // TODO: 추후 필요시 클릭처리
                    }
                }
            }
        }
    }
    
    /// 월 변경
    func changeMonth(by value: Int) {
        self.displayDate = clendarService.adjustedMonth(by: value, date: displayDate)
    }
}

#Preview {
    SWCalendarView(
        displayDate: .now,
        selectedDate: .now,
        today: .now
    )
}
