//
//  UsersResponse.swift
//  VK
//
//  Created by Андрей Шкундалёв on 20.10.21.
//

import Foundation

struct UsersResponseWrapped: Decodable {
    
    let response: [UsersResponse]
}

struct UsersResponse: Decodable {
    
    let firstName: String
    let lastName: String
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    let photo200: String
    let counters: Counters
}

struct Counters: Decodable {
    
    let friends: Int
    let photos: Int
    let groups: Int
}
