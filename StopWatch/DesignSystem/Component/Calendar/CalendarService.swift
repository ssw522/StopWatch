//
//  CalendarService.swift
//  StopWatch
//
//  Created by iOS신상우 on 12/15/24.
//

import Foundation

final class CalendarService {
    var calendar = Calendar.current
    
    /// 특정 해당 날짜
    func getDate(for index: Int, date: Date) -> Date {
        guard let firstDayOfMonth = calendar.date(
            from: DateComponents(
                year: calendar.component(.year, from: date),
                month: calendar.component(.month, from: date),
                day: 1
            )
        ) else {
            return Date()
        }
        
        var dateComponents = DateComponents()
        dateComponents.day = index
        
        let timeZone = TimeZone.current
        let offset = Double(timeZone.secondsFromGMT(for: firstDayOfMonth))
        dateComponents.second = Int(offset)
        
        let date = calendar.date(byAdding: dateComponents, to: firstDayOfMonth) ?? Date()
        return date
    }
    
    /// 해당 월에 존재하는 일자 수
    func numberOfDays(in date: Date) -> Int {
        return Calendar.current.range(of: .day, in: .month, for: date)?.count ?? 0
    }
    
    /// 해당 월의 첫 날짜가 갖는 해당 주의 몇번째 요일
    func firstWeekdayOfMonth(in date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: date)
        let firstDayOfMonth = calendar.date(from: components)!
        
        return calendar.component(.weekday, from: firstDayOfMonth)
    }
    
    /// 이전 월 마지막 일자
    func previousMonth(date: Date) -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        let firstDayOfMonth = Calendar.current.date(from: components)!
        let previousMonth = Calendar.current.date(byAdding: .month, value: -1, to: firstDayOfMonth)!
        
        return previousMonth
    }
    
    /// 다음 월 마지막 일자
    func nextMonth(date: Date) -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        let firstDayOfMonth = Calendar.current.date(from: components)!
        let nextMonth = Calendar.current.date(byAdding: .month, value: +1, to: firstDayOfMonth)!
        
        return nextMonth
    }
    
    /// 이전 월로 이동 가능한지 확인
    func canMoveToPreviousMonth(date: Date) -> Bool {
        let calendar = Calendar.current
        let targetDate = calendar.date(byAdding: .month, value: -1, to: date) ?? date
        
        if adjustedMonth(by: -1, date: date) < targetDate {
            return false
        }
        
        return true
    }
    
    /// 다음 월로 이동 가능한지 확인
    func canMoveToNextMonth(date: Date) -> Bool {
        let calendar = Calendar.current
        let targetDate = calendar.date(byAdding: .month, value: 1, to: date) ?? date
        
        if adjustedMonth(by: 1, date: date) > targetDate {
            return false
        }
        return true
    }
    
    /// 변경하려는 월 반환
    func adjustedMonth(by value: Int, date: Date) -> Date {
        if let newMonth = Calendar.current.date(byAdding: .month, value: value, to: date) {
            return newMonth
        }
        
        return date
    }
    
    /// 변경하려는 일 반환
    func adjustedDay(by value: Int, date: Date) -> Date {
        if let newMonth = Calendar.current.date(byAdding: .day, value: value, to: date) {
            return newMonth
        }
        
        return date
    }
    
    func getWeekDay(with date: Date, format: WeekdayFormat) -> String {
        let weekDayRawValue = calendar.component(.weekday, from: date)
        return format.values[weekDayRawValue-1]
    }
    
    func getDay(with date: Date) -> Int {
        Calendar.current.component(.day, from: date)
    }
    
    func getMonth(with date: Date) -> Int {
        Calendar.current.component(.month, from: date)
    }
}
