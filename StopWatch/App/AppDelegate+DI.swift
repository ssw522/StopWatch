//
//  AppDelegate+DI.swift
//  StopWatch
//
//  Created by iOS신상우 on 1/23/25.
//

import Foundation
import RealmSwift

extension AppDelegate {
    func injectDependency() {
        do {
            
            Realm.Configuration.defaultConfiguration.deleteRealmIfMigrationNeeded = true
            let realm = try Realm(configuration: .defaultConfiguration)
            DependencyBox.live
                .register((any CategoryRepository).self) {
                    CategoryRepositoryImpl(realm: realm)
                }
                .register((any TodoRepository).self) {
                    TodoRepositoryImpl(realm: realm)
                }
                .register((any TimeCheckReopsitory).self) {
                    TimeCheckReopsitoryImpl(realm: realm)
                }
//            let timeCheckRepo = TimeCheckReopsitoryImpl(realm: realm)
//            
//            
//            let allEntity = try? timeCheckRepo.getAll()
//            try? timeCheckRepo.delete(entities: allEntity ?? [])
        } catch {
            print("😅😅😅😅\(error)😅😅😅😅")
        }
    }
}
