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
    
    func update<T>(entity: Todo, keypaths: [(WritableKeyPath<Todo, T>, T)]) throws {
        var entityToUpdate = entity
        try? realm.write {
            for (keyPath, newValue) in keypaths {
                entityToUpdate[keyPath: keyPath] = newValue
            }
        }
    }
    
    func update<T>(entities: [Todo], keypaths: [(WritableKeyPath<Todo, T>, T)]) throws {
        for entity in entities {
            try update(entity: entity, keypaths: keypaths)
        }
    }
    
    func delete(entity: Todo) throws {
        try realm.write {
            realm.delete(entity)
        }
    }
    
    func delete(entities: [Todo]) throws {
        for entity in entities {
            try delete(entity: entity)
        }
    }
}
