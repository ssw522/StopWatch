//
//  TimeFormatter.swift
//  StopWatch
//
//  Created by iOS신상우 on 2/2/25.
//

import Foundation

struct TimeFormatter {
    
    static func toTimeString(with timeInterval: TimeInterval, format: TimeFormat = .basic, useCompactTimeFormat: Bool = false) -> String {
        let hours = timeInterval / 3600
        let minutes = (timeInterval.truncatingRemainder(dividingBy: 3600)) / 60
        let seconds = timeInterval.truncatingRemainder(dividingBy: 60)
        
        if useCompactTimeFormat {
            if hours.toInt > .zero {
                return String(format: format.hourMinuteOnly, hours.toInt, minutes.toInt)
            } else {
                return String(format: format.minuteSecondOnly, minutes.toInt, seconds.toInt)
            }
        } else {
            return String(format: format.rawValue, hours.toInt, minutes.toInt, seconds.toInt)
        }
    }
    
    enum TimeFormat: String {
        /// 00 : 00 : 00
        case basic = "%02d : %02d : %02d"
        
        /// 00시간 00분 00초
        case HHMMssKorean = "%02d시간 %02d분 %02d초"
        
        var hourMinuteOnly: String {
            switch self {
            case .HHMMssKorean:
                "%02d시간 %02d분"
            // 미지원 포맷
            default:
                self.rawValue
            }
        }
        
        var minuteSecondOnly: String {
            switch self {
            case .HHMMssKorean:
                "%02d분 %02d초"
            // 미지원 포맷
            default:
                self.rawValue
            }
        }
    }
}

fileprivate extension Double {
    var toInt: Int {
        Int(self)
    }
}
