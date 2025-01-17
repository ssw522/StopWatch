//
//  WeekdayFormat.swift
//  StopWatch
//
//  Created by iOS신상우 on 12/15/24.
//

import Foundation

enum WeekdayFormat {
    case korea_short
    case korea_long
    case english_short
    case english_long
    case custom([String])
    
    var values: [String] {
        switch self {
            
        case .korea_short:
            ["일","월","화","수","목","금","토"]
        case .korea_long:
            ["일요일","월요일","화요일","수요일","목요일","금요일","토요일"]
        case .english_short:
            ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
        case .english_long:
            ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
        case .custom(let array):
            array
        }
    }
}
