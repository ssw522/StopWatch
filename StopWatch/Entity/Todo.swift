//
//  Todo.swift
//  StopWatch
//
//  Created by iOS신상우 on 11/24/24.
//

import Foundation
import RealmSwift

class Todo: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var date: Date?
    @Persisted var content: String
    @Persisted var stateIndex: Int = 0
    @Persisted var category: Category?
    
    convenience init(id: String = UUID().uuidString, date: Date? = nil, content: String, stateIndex: Int, category: Category? = .none) {
        self.init()
        self.id = id
        self.date = date
        self.content = content
        self.stateIndex = stateIndex
        self.category = category
    }
}

// MARK: - Mock Data
extension Todo {
    static var mockData1: Todo {
        .init(
            date: .now,
            content: "객체지향프로그래밍 공부",
            stateIndex: 0,
            category: .programmingMock
        )
    }
    
    static var mockData2: Todo {
        .init(
            date: .now,
            content: "단어 30개 외우기",
            stateIndex: 0,
            category: .englishMock
        )
    }
    
    static var mockData3: Todo {
        .init(
            date: .now,
            content: "가슴 운동 50분",
            stateIndex: 2,
            category: .exerciseMock
        )
    }
}
