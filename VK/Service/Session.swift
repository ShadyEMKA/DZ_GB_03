//
//  Session.swift
//  VK
//
//  Created by Андрей Шкундалёв on 18.10.21.
//

import Foundation

final class Session {
    
    static let shared = Session()
    private var userDefaults = UserDefaults.standard
    
    private init() {}
    
    var token: String? {
        get {
            userDefaults.string(forKey: "token")
        }
        set {
            userDefaults.set(newValue, forKey: "token")
        }
    }
    var userId: Int? {
        get {
            userDefaults.integer(forKey: "userId")
        }
        set {
            userDefaults.set(newValue, forKey: "userId")
        }
    }
}
