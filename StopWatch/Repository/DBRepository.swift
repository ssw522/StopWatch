//
//  DBRepository.swift
//  StopWatch
//
//  Created by iOS신상우 on 1/24/25.
//

import Foundation
import RealmSwift

protocol DBRepository {
    associatedtype Entity = Object
    
    func getAll() throws -> [Entity]
    
    func create(entity: Entity) throws
    
//    func update<T>(id: String, keypaths: [(WritableKeyPath<Entity, T>, T)]) throws
    
    func update<T>(entity: Entity, keypaths: [(WritableKeyPath<Entity, T>, T)]) throws
    
    func update<T>(entities: [Entity], keypaths: [(WritableKeyPath<Entity, T>, T)]) throws
    
    func delete(entity: Entity) throws
    
    func delete(entities: [Entity]) throws
}
