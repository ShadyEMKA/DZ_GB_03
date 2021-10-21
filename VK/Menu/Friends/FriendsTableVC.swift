//
//  FriendsTableVC.swift
//  VK
//
//  Created by Андрей Шкундалёв on 20.09.21.
//

import UIKit

class FriendsTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak private var tableView: UITableView!
    
    private let fetcher = NetworkDataFetcher()
    private var friends = [FriendModel]()
    
    lazy private var refreshControlFriends: UIRefreshControl = {
        let refreshControlFriends = UIRefreshControl()
        refreshControlFriends.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControlFriends
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        loadingFriends()
    }
    
    private func configure() {
        
        tableView.addSubview(refreshControlFriends)
        tableView.separatorStyle = .none
        tableView.contentInset.top = CGFloat(10)
    }
    
    private func loadingFriends() {
        
        fetcher.getFriends { response in
            self.friends = response.items.compactMap { friend in
                FriendModel(name: friend.fullName, avatar: friend.photo100, status: friend.online)
            }
            self.tableView.reloadData()
        }
        refreshControlFriends.endRefreshing()
    }
    
    @objc private func refresh() {
        
        loadingFriends()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.tableView.dequeueReusableCell(withIdentifier: Constants.Cell.friend, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let newVC = cell as? FriendsTableViewCell {
            let friend = friends[indexPath.row]
            newVC.set(avatar: friend.avatar, name: friend.name, status: friend.status)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Всего друзей - \(friends.count)"
    }
}
