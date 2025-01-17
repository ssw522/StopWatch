//
//  DateFormat.swift
//  STLess
//
//  Created by iOS신상우 on 5/29/24.
//

// MARK: - 킹 메이슨거 훔쳐옴 😎

import Foundation

enum DateFormat: String {
    /// 년.월.일
    case yyyyMMdd = "yyyy.MM.dd"

    /// 한국어 년월일 (yyyy년 MM월 dd일)
    case yyyyMMddKorean = "yyyy년 MM월 dd일"

    /// 한국어 년월일 (yyyy년 M월 d일)
    case yyyyMdKorean = "yyyy년 M월 d일"

    /// 한국어 월일 (MM월 dd일)
    case MMddKorean = "MM월 dd일"

    /// 년.월
    case yyyyMM = "yyyy.MM"

    /// 월.일
    case MMdd = "MM.dd"
    
    /// 월.일
    case Mdd = "M.dd"
    
    /// 시
    case HH = "HH"

    /// 년.월.일 시:분:초
    case dateTime = "yyyy.MM.dd HH:mm:ss"

    /// 년.월.일 시:분
    case yyyyMMddHHmm = "yyyy.MM.dd HH:mm"

    /// 년.월.일 오전/오후 시:분
    case yyyyMMddahhmm = "yyyy.MM.dd a hh:mm"

    /// 년.월.일 오전/오후 시(24):분
    case yyyyMMddaHHmm = "yyyy.MM.dd a HH:mm"

    /// 시:분:초
    case HHmmss = "HH:mm:ss"

    /// 시:분
    case HHmm = "HH:mm"

    /// 오전/오후 시:분
    case ahhmm = "a hh:mm"

    /// 축약 요일 (월, 화)
    case ee = "EE"

    /// 서버 날짜, 시간 (년-월-일 시:분:초)
    case serverDateTime = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
    
    /// MMM, yyyy
    case MMMyyyy = "MMMM, yyyy"
}

// MARK: - DateFormatter

extension DateFormat {
    private static var cachedFormatters: [String: DateFormatter] = [:]

    // MARK: - Public

    /// 각 DateFormat에 따른 formatter
    ///
    /// - 미리 생성해둔 인스턴스를 재사용함
    /// - DateFormatter 의 생성 비용은 굉장히 비싸서 재사용 하는 것이 효율적
    /// - DateFormatter는 thread-safe 하기에 전역적으로 사용 가능
    var formatter: DateFormatter {
        Self.cachedFormatter(
            ofDateFormat: rawValue,
            localeFormat: .korea
        )
    }

    static func cachedFormatter(
        ofDateFormat dateFormat: String,
        localeFormat: LocaleFormat
    ) -> DateFormatter {
        if let cachedFormatter = DateFormat.cachedFormatters[dateFormat+localeFormat.rawValue] { return cachedFormatter
        }

        let formatter = makeFormatter(
            withDateFormat: dateFormat,
            localeFormat: localeFormat
        )
        
        DateFormat.cachedFormatters[dateFormat+localeFormat.rawValue] = formatter
        return formatter
    }

    // MARK: - Private Methods

    private static func makeFormatter(withDateFormat dateFormat: String, localeFormat: LocaleFormat) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale(identifier: localeFormat.rawValue)
        
        return formatter
    }
}
