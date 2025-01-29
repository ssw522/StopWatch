//
//  TodoRepository.swift
//  StopWatch
//
//  Created by iOS신상우 on 1/26/25.
//

import Foundation
import RealmSwift

protocol TodoRepository: DBRepository where Entity == Todo {
    
}

final class TodoRepositoryImpl: TodoRepository {
    private let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func getAll() throws -> [Todo] {
        realm.objects(Todo.self).map { $0 }
    }
    
    func create(entity: Todo) throws {
        try realm.write {
            realm.add(entity)
        }
    }
}
