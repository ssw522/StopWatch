//
//  CategoryRepository.swift
//  StopWatch
//
//  Created by iOS신상우 on 1/23/25.
//

import Foundation
import RealmSwift

protocol CategoryRepository: DBRepository where Entity == Category  {
    
}

final class CategoryRepositoryImpl: CategoryRepository {
   
    
    private let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func update<T>(entity: Category, keypaths: [(WritableKeyPath<Category, T>, T)]) throws {
        var entityToUpdate = entity
        try realm.write {
            for (keyPath, newValue) in keypaths {
                entityToUpdate[keyPath: keyPath] = newValue
            }
        }
    }
    
    func update<T>(entities: [Category], keypaths: [(WritableKeyPath<Category, T>, T)]) throws {
        for entity in entities {
            try update(entity: entity, keypaths: keypaths)
        }
        
    }
    
    func delete(entity: Category) throws {
        try realm.write {
            realm.delete(entity)
        }
    }
    
    func delete(entities: [Category]) throws {
        for entity in entities {
            try delete(entity: entity)
        }
    }
    
    func getAll() throws -> [Category] {
        let result = realm.objects(Category.self)
        return result.map { $0 }
    }
    
    func create(entity: Entity) throws {
        try realm.write {
            realm.add(entity)
        }
    }
}
