//
//  Todo.swift
//  StopWatch
//
//  Created by iOS신상우 on 11/24/24.
//

import Foundation
import RealmSwift

class Todo: Object {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var date: Date?
    @Persisted var content: String
    @Persisted var stateIndex: Int = 0
}
