//
//  Session.swift
//  VK
//
//  Created by Андрей Шкундалёв on 18.10.21.
//

import Foundation

final class Session {
    
    static let shared = Session()
    
    private init() {}
    
    var token: String?
    var userId: Int?
}
