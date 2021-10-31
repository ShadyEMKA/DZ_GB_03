//
//  GroupModel.swift
//  VK
//
//  Created by Андрей Шкундалёв on 22.09.21.
//

import UIKit
import RealmSwift

class GroupModel: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var avatar: String = ""
}
