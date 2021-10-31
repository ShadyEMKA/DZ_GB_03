//
//  LocaleDataManager.swift
//  VK
//
//  Created by Андрей Шкундалёв on 27.10.21.
//

import Foundation
import RealmSwift

class LocaleDataManager {
    
    private var realm = try! Realm()
    
    func save<T: Object>(object: T) {
        try! realm.write({
            realm.add(object)
        })
    }
    
    func load<T: Object>(type: T.Type) -> Results<T> {
        return realm.objects(type.self)
    }
}
