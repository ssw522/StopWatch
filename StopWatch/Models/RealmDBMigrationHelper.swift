//
//  RealmDBMigrationHelper.swift
//  StopWatch
//
//  Created by iOS신상우 on 11/24/24.
//

import Foundation
import RealmSwift

/*
 마이그레이션 참고 링크
 https://www.mongodb.com/ko-kr/docs/realm-sdks/swift/10.9.0/Structs/Migration.html#/s:10RealmSwift9MigrationV6create_5valueAA13DynamicObjectCSS_yptF
 */

class RealmDBMigrationHelper {
    func migration() {
        let config = Realm.Configuration(
            schemaVersion: 2,
            migrationBlock: { migration, oldSchemaVersion in
                migration.enumerateObjects(ofType: DailyData.className()) { oldObject, _ in
                    guard let dailyData = oldObject else {
                        return
                    }
                    
                    // 1. 새로운 객체 만들고
                    var todo = Todo()
                    todo["totalTime"]
//                    todo.date =
                    // 2. 객체 새로 생성
//                    migration.create(<#T##typeName: String##String#>, value: <#T##Any#>)
                }
            }
        )
    }
}
