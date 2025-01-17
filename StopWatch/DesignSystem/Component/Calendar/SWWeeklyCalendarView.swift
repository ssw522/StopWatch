//
//  SWWeeklyCalendarView.swift
//  StopWatch
//
//  Created by iOS신상우 on 12/15/24.
//

import SwiftUI

struct SWWeeklyCalendarView: View {
    private let calendarService = CalendarService()
    @State var displayDate: Date?
    @State var selectedDate: Date?
    @State var dates: [Date] = []
    
    private var currentDate: Date { displayDate ?? .now }
    
    var body: some View {
        VStack(spacing: .zero) {
            HStack(spacing: 8) {
                Image(systemName: "calendar")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(Color.black)
                Text(currentDate.formattedString(by: .MMMyyyy, local: .usa))
                    .font(.pretendard(size: 22, weight: .regular))
                    .redacted(reason: .privacy)
                    .animation(.spring, value: displayDate)
            }
            
            FixedSpacer(20)
            ScrollView(.horizontal) {
                LazyHStack(spacing: .zero) {
                    ForEach(dates, id: \.self) { date in
                        let symbol = calendarService.getWeekDay(with: date, format: .english_short)
                        let day = calendarService.getDay(with: date)
                        
                        Group {
                            if date.formattedString(by: .yyyyMM) == currentDate.formattedString(by: .yyyyMM) {
                                CalendarLargeCell(
                                    day: day,
                                    weekdaySymbol: symbol,
                                    isSelected: selectedDate?.formattedString(by: .yyyyMMdd) == date.formattedString(by: .yyyyMMdd)
                                )
                                .onTapGesture {
                                    selectedDate = date
                                }
                            } else {
                                CalendarLargeCell(day: day, weekdaySymbol: symbol)
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width/5)
                        .scaleEffect(
                            getScale(
                                scalar: daysBetween(start: date, end: currentDate)
                            )
                        )
                        .opacity(date.formattedString(by: .yyyyMMdd) == currentDate.formattedString(by: .yyyyMMdd) ? 1.0 : 0.6)
                        .animation(.spring, value: displayDate)
                        .id(date.formattedString(by: .yyyyMMdd) + currentDate.formattedString(by: .yyyyMM))
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: $displayDate, anchor: .center)
            .scrollIndicators(.hidden)
            .onScrollPhaseChange { oldPhase, newPhase in
                if !newPhase.isScrolling {
                    let days = calendarService.numberOfDays(in: currentDate)
                    self.dates = (-7..<days+7).map { calendarService.getDate(for: $0, date: currentDate) }
                }
            }
            .onChange(of: dates) { oldValue, newValue in
                print("dates change")
            }
        }
        .onAppear {
            displayDate = .now
            let days = calendarService.numberOfDays(in: currentDate)
            dates = (-7..<days+7).map { calendarService.getDate(for: $0, date: currentDate) }
            displayDate = .now
        }
    }
    
    /// 월 변경
    func changeMonth(by value: Int) {
        
    }
    
    private func daysBetween(start: Date, end: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: start, to: end)
        return abs(components.day ?? 0)
    }
    
    private func getScale(scalar: Int) -> CGFloat {
        switch scalar {
        case 0: 1
        case 1: 0.8
        case 2: 0.6
        case 3: 0.4
        default: 0.8
        }
    }
}

struct CalendarLargeCell: View {
    var day: Int
    var weekdaySymbol: String
    var isSelected: Bool = false
    
    var body: some View {
        VStack(spacing: 6) {
            Text("\(day)")
                .font(.pretendard(size: 46, weight: .semibold))
//                .frame(width: 30, height: 30)
//                .background(isSelected ? .gray.opacity(0.3) : .clear)
//                .clipShape(.circle)
            
            Text(weekdaySymbol)
                .font(.pretendard(size: 16, weight: .regular))
                .foregroundStyle(Color.gray)
        }
        .foregroundStyle(Color.black)
    }
}

#Preview(body: {
    SWWeeklyCalendarView(displayDate: .now)
})
