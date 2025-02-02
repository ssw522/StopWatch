//
//  TimeCheck.swift
//  StopWatch
//
//  Created by iOS신상우 on 11/24/24.
//

import Foundation
import RealmSwift

class TimeCheck: Object {
    @Persisted(primaryKey: true) var id : String
    @Persisted var startDate: Date
    @Persisted var endDate: Date
    @Persisted var breakTime: Double
    @Persisted var todo: Todo?
    
    convenience init(id : String = UUID().uuidString, startDate: Date, endDate: Date, breakTime: Double, todo: Todo) {
        self.init()
        self.id = id
        self.startDate = startDate
        self.endDate = endDate
        self.breakTime = breakTime
        self.todo = todo
    }
}

extension TimeCheck {
    var focusTime: Double {
        endDate.timeIntervalSince1970 - startDate.timeIntervalSince1970 - breakTime
    }
}
