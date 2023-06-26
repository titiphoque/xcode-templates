//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import RealmSwift

class ___VARIABLE_productName___Migrator {
    static let currentSchemaVersion: UInt64 = 1
    
    static private func migrationBlock(migration: Migration, oldSchemaVersion: UInt64) {
        debugPrint("Migrating realm from schema version \(oldSchemaVersion) to schema version \(currentSchemaVersion)")
        //if oldSchemaVersion < 1 {
        //}
    }
    
    static func setDefaultConfiguration() {
        let config = Realm.Configuration(schemaVersion: currentSchemaVersion, migrationBlock: migrationBlock)
        Realm.Configuration.defaultConfiguration = config
    }
}