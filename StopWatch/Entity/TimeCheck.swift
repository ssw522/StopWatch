//
//  TimeCheck.swift
//  StopWatch
//
//  Created by iOS신상우 on 11/24/24.
//

import Foundation
import RealmSwift

class TimeCheck: Object {
    @Persisted var startDate: Date
    @Persisted var endDate: Date
    @Persisted var category: Category?
}
