//
//  UserResponse.swift
//  VK
//
//  Created by Андрей Шкундалёв on 20.10.21.
//

import Foundation

struct FriendsResponseWrapped: Decodable {
    
    let response: FriendsResponse
}

struct FriendsResponse: Decodable {
    
    let count: Int
    let items: [Friend]
}

struct Friend: Decodable {
    
    let id: Int
    let firstName: String
    let lastName: String
    let online: Int
    let photo100: String
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
}
