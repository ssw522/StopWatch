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
    
    func getAll() throws -> [Category] {
        let realm = try Realm()
        let result = realm.objects(Category.self)
        return result.map { $0 }
    }
    
    func create(entity: Entity) throws {
        let realm = try Realm()
        try realm.write {
            realm.add(entity)
        }
    }
}
