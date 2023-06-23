//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import UIKit
import Foundation
import RealmSwift

class Abstract___VARIABLE_productName___ {
    let realm = try! Realm()

    func printDatabaseFilePath() {
#if DEBUG
        guard let path = realm.configuration.fileURL?.path else {
            debugPrint("🚨 Realm file path not fund")
            return
        }
        
        debugPrint("📁 Realm Path: \(path)")
#endif
    }
    
    func thaw<T: Object>(object: T) -> T? {
        realm.thaw(object)
    }
    
    func beginWrite() {
        if realm.isInWriteTransaction == false {
            realm.beginWrite()
        }
    }
    
    func cancelWrite() {
        if realm.isInWriteTransaction == true {
            realm.cancelWrite()
        }
    }
    
    func commitWrite() throws {
        if realm.isInWriteTransaction == true {
            try realm.commitWrite()
        }
    }
    
    func write(block: () -> Void) throws {
        try realm.write(block)
    }
    
    @discardableResult
    func refresh() -> Bool {
        realm.refresh()
    }
    
    // MARK: - Generics
    
    func object<T, K>(ofType type: T.Type, forPrimaryKey key: K) -> T? where T: RealmSwift.Object {
        realm.object(ofType: type, forPrimaryKey: key)
    }
    
    func all<T: Object>(_ type: T.Type) -> Results<T> {
        realm.objects(type)
    }
    
    func first<T: Object>(_ type: T.Type) -> T? {
        all(type).first
    }
    
    func last<T: Object>(_ type: T.Type) -> T? {
        all(type).last
    }
    
    func allInArray<T: Object>(_ type: T.Type) -> [T] {
        var allInArray = [T]()
        let allInResults = realm.objects(type)
        allInArray.append(contentsOf: allInResults)
        return allInArray
    }
    
    func addObject<T: Object>(_ object: T) {
        beginWrite()
        realm.add(object, update: Realm.UpdatePolicy.all)
        try! commitWrite()
    }
    
    func addObjects<T: Object>(_ objects: [T]) {
        beginWrite()
        realm.add(objects, update: Realm.UpdatePolicy.all)
        try! commitWrite()
    }
    
    func deleteObject<T: Object>(_ object: T) {
        beginWrite()
        realm.delete(object)
        try! commitWrite()
    }
    
    func deleteObjects<T: Object>(_ objects: List<T>) {
        beginWrite()
        realm.delete(objects)
        try! commitWrite()
    }
    
    func deleteObjects<T: Object>(_ objects: Results<T>) {
        beginWrite()
        realm.delete(objects)
        try! commitWrite()
    }
    
    func deleteObjects<T: Object>(_ objects: [T]) {
        beginWrite()
        for obj in objects {
            realm.delete(obj)
        }
        try! commitWrite()
    }
    
    func deleteAll<T: Object>(_ type: T.Type) {
        beginWrite()
        realm.delete(all(type))
        try! commitWrite()
    }
    
    func deleteAll(except types: Object.Type...) {
        try? realm.write {
            realm.configuration.objectTypes?
                .filter { type in
                    types.contains { $0 == type } == false
                }
                .compactMap { $0 as? Object.Type }
                .forEach { objectType in
                    realm.delete(realm.objects(objectType.self))
                }
        }
    }
    
    func deleteAllObjectsFromAnyClasses() {
        try? write {
            realm.deleteAll()
        }
    }
    
    /// Add new object, update existing object, delete objects not added/updated
    func add<T: Object & RealmSafeIdentifiable>(objects: [T], shouldDeleteOthers: Bool) {
        guard shouldDeleteOthers else {
            addObjects(objects)
            return
        }
        
        let ids = objects.compactMap { $0.uid }
        let objectsToDelete = all(T.self).filter("not %K in %@", T.uidPropertyName, ids)
        
        #if DEBUG && false
        debugPrint("Keeping ids \(ids)")
        let uidsToDelete = objectsToDelete.toArray().map { $0.uid }
        debugPrint("Should delete \(uidsToDelete) objects")
        #endif
        
        addObjects(objects)
        deleteObjects(objectsToDelete)
    }
}
