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
}
