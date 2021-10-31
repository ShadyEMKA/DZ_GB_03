//
//  UserModel.swift
//  VK
//
//  Created by Андрей Шкундалёв on 22.09.21.
//

import UIKit
import RealmSwift

class FriendModel: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var avatar: String = ""
    @objc dynamic var status: Int = 0
    @objc dynamic var id: Int = 0
}
