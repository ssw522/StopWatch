//
//  Category.swift
//  StopWatch
//
//  Created by iOS신상우 on 11/24/24.
//

import Foundation
import RealmSwift

class Category: Object {
    @Persisted(primaryKey: true) var id : String
    @Persisted var name: String
    
    convenience init(id: String = UUID().uuidString, name: String) {
        self.init()
        self.id = id
        self.name = name
    }
}


// MARK: - Mock Data
extension Category {
    static var programmingMock: Category {
        .init(name: "프로그래밍")
    }
    
    static var englishMock: Category {
        .init(name: "영어")
    }
    
    static var exerciseMock: Category {
        .init(name: "운동")
    }
}
