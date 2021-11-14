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
    
    func save<T: Object>(object: [T]) {
        try! realm.write({
            realm.add(object)
        })
    }
    
    func load<T: Object>(type: T.Type) -> Results<T> {
        return realm.objects(type.self)
    }
    
    func delete<T: Object>(object: Results<T>) {
        try! realm.write({
            realm.delete(object)
        })
    }
    
    func update<T: Object>(type: T.Type, property: String, oldValue: Any, newValue: Any) {
        guard let object = load(type: type).filter("\(property) == %@", oldValue).first else { return }
        try! realm.write({
            object.setValuesForKeys([property: newValue])
        })
    }
}
