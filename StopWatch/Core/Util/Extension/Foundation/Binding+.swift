//
//  Binding+.swift
//  StopWatch
//
//  Created by iOS신상우 on 1/28/25.
//

import SwiftUI

// Binding<Value?>에서 Binding<Value>로 변환하는 익스텐션
extension Binding {
    init(_ source: Binding<Value?>, default defaultValue: Value) {
        self.init(
            get: { source.wrappedValue ?? defaultValue },
            set: { source.wrappedValue = $0 }
        )
    }
}
