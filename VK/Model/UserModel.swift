//
//  UserModel.swift
//  VK
//
//  Created by Андрей Шкундалёв on 20.10.21.
//

import Foundation
import RealmSwift

class UserModel: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var avatar: String = ""
    @objc dynamic var countFriends: Int = 0
    @objc dynamic var coumtGroups: Int = 0
    @objc dynamic var countPhoto: Int = 0
}
