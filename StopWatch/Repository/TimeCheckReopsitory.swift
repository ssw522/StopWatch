//
//  TimeCheckReopsitory.swift
//  StopWatch
//
//  Created by iOS신상우 on 2/2/25.
//

import Foundation
import RealmSwift

protocol TimeCheckReopsitory: DBRepository where Entity == TimeCheck {
    
}

final class TimeCheckReopsitoryImpl: TimeCheckReopsitory {
    
    private let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func getAll() throws -> [TimeCheck] {
        realm.objects(TimeCheck.self).map { $0 }
    }
    
    func create(entity: TimeCheck) throws {
        try realm.write {
            realm.add(entity)
        }
    }
    
    func update<T>(entity: TimeCheck, keypaths: [(WritableKeyPath<TimeCheck, T>, T)]) throws {
        var entityToUpdate = entity
        
        try? realm.write {
            for (keyPath, newValue) in keypaths {
                entityToUpdate[keyPath: keyPath] = newValue
            }
        }
    }
    
    func update<T>(entities: [TimeCheck], keypaths: [(WritableKeyPath<TimeCheck, T>, T)]) throws {
        for entity in entities {
            try update(entity: entity, keypaths: keypaths)
        }
    }
    
    func delete(entity: TimeCheck) throws {
        try realm.write {
            realm.delete(entity)
        }
    }
    
    func delete(entities: [TimeCheck]) throws {
        for entity in entities {
            try delete(entity: entity)
        }
    }
}
