//
//  Category.swift
//  StopWatch
//
//  Created by iOS신상우 on 11/24/24.
//

import Foundation
import RealmSwift

class Category: Object {
    @Persisted(primaryKey: true) var id : String = UUID().uuidString // 과목번호
    @Persisted var name: String // 과목명
    @Persisted var colorCode: Int //과목색상코드
}
