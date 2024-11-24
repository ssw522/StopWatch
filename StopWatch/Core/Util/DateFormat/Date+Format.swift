//
//  Date+.swift
//  STLess
//
//  Created by iOS신상우 on 5/19/24.
//

import SwiftUI

extension String {
    func date(fromFormat format: DateFormat) -> Date {
        format.formatter.date(from: self) ?? Date()
    }
}

extension Date {
    func formattedString(by dateFormat: DateFormat) -> String {
        return dateFormat.formatter.string(from: self)
    }

    func formattedString(format: String) -> String {
        let formatter = DateFormat.cachedFormatter(ofDateFormat: format)
        return formatter.string(from: self)
    }
}

