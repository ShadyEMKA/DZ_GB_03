//
//  Constants.swift
//  VK
//
//  Created by Андрей Шкундалёв on 22.09.21.
//

import UIKit

enum Constants {
    
    enum Storyboard {
        static let main: UIStoryboard = .init(name: "Main", bundle: nil)
        static let menu: UIStoryboard = .init(name: "Menu", bundle: nil)
        static let friends: UIStoryboard = .init(name: "Friends", bundle: nil)
        static let photoFriend: UIStoryboard = .init(name: "PhotoFriend", bundle: nil)
        static let fullPhoto: UIStoryboard = .init(name: "FullPhoto", bundle: nil)
        static let searchGroup: UIStoryboard = .init(name: "SearchGroup", bundle: nil)
    }
    
    enum Cell {
        static let friend: String = "FriendCell"
        static let photoFriend: String = "PhotoFriendCell"
        static let group: String = "GroupCell"
        static let searchGroup: String = "SearchGroupCell"
        static let news: String = "NewsCell"
    }
}
