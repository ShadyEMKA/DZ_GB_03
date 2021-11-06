//
//  GroupResponse.swift
//  VK
//
//  Created by Андрей Шкундалёв on 20.10.21.
//

import Foundation

struct GroupsResponseWrapped: Decodable {
    
    let response: GroupsResponse
}

struct GroupsResponse: Decodable {
    
    let count: Int
    let items: [Group]
}

struct Group: Decodable {
    
    let id: Int
    let name: String
    let photo100: String
}
