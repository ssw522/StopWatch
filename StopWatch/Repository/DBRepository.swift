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

enum ComparisonOperator {
    case greaterThan
    case greaterThanOrEqual
    case lessThan
    case lessThanOrEqual
    case equal

    func apply<T: Comparable>(_ lhs: T, _ rhs: T) -> Bool {
        switch self {
        case .greaterThan: return lhs > rhs
        case .greaterThanOrEqual: return lhs >= rhs
        case .lessThan: return lhs < rhs
        case .lessThanOrEqual: return lhs <= rhs
        case .equal: return lhs == rhs
        }
    }
}
