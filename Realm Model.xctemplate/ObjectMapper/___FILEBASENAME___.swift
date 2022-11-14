//
// ___FILENAME___
// ___PROJECTNAME___
//
// Created by ___FULLUSERNAME___ on ___DATE___.
// ___COPYRIGHT___
//

import RealmSwift
import ObjectMapper

class ___FILEBASENAMEASIDENTIFIER___: Object, StaticMappable {

    /// Unique identifier
    @Persisted(primaryKey: true) var uid: String?

    /*
    @Persisted var simpleProperty: String? // Brand
    @Persisted var listProperty = List<<#YourObject#>>()
    @Persisted var objectProperty: <#RewardsSystem?#>
    @objc @Persisted var @objcProperty: Bool = true
    */

    // MARK: - Mapping
    
    static func objectForMapping(map: ObjectMapper.Map) -> BaseMappable? {
        ___FILEBASENAMEASIDENTIFIER___()
    }
    
    func mapping(map: ObjectMapper.Map) {
        uid <- map["uid"]
    }    
}