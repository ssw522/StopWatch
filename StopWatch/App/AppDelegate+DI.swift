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
                    CategoryRepositoryImpl()
                }
                .register((any TodoRepository).self) {
                    TodoRepositoryImpl(realm: realm)
                }
        } catch {
            print("😅😅😅😅\(error)😅😅😅😅")
        }
    }
}
