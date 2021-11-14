//
//  FirebaseDB.swift
//  VK
//
//  Created by Андрей Шкундалёв on 14.11.21.
//

import UIKit
import Firebase

class FirebaseDB {
    
    static let shared = FirebaseDB()
    private let currentUserId = UserDefaults.standard.integer(forKey: "userId")
    
    private var usersRef = Database.database().reference().child("users")
    
    func save(data: GroupModel) {
        usersRef.child("\(currentUserId)").child("\(data.id)").setValue(data.representable)
    }
}
