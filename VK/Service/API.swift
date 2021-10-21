//
//  API.swift
//  VK
//
//  Created by Андрей Шкундалёв on 20.10.21.
//

import Foundation

struct API {
    static let scheme = "https"
    static let host = "api.vk.com"
    static let friendsGet = "/method/friends.get"
    static let groupsGet = "/method/groups.get"
    static let usersGet = "/method/users.get"
    static let searchGetHints = "/method/search.getHints"
    static let groupsSearch = "/method/groups.search"
    static let version = "5.131"
}
