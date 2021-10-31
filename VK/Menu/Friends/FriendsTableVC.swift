//
//  FriendsTableVC.swift
//  VK
//
//  Created by Андрей Шкундалёв on 20.09.21.
//

import UIKit

class FriendsTableVC: UIViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    
    private let fetcher = NetworkDataFetcher()
    private var friendsAndLitters = [Character: [FriendModel]]()
    private var litters: [Character] {
        var array = [Character]()
        for item in friendsAndLitters.keys {
            array.append(item)
        }
        let sortedArray = array.sorted { $0 < $1 }
        return sortedArray
    }
    
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
        
        fetcher.getFriends { [weak self] response in
            guard let self = self else { return }
            let friends = response.items.compactMap { friend in
                FriendModel(value: [friend.fullName, friend.photo100, friend.online, friend.id])
            }
            self.friendsAndLitters = self.littersFromArray(array: friends)
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControlFriends.endRefreshing()
            }
        }
    }
    
    @objc private func refresh() {
        
        loadingFriends()
    }
    
    private func littersFromArray(array: [FriendModel]) -> [Character: [FriendModel]] {
        var result = [Character: [FriendModel]]()
        for item in array {
            guard let first = item.name.first else { return [:] }
            if result[first] != nil {
                result[first]!.append(item)
            } else {
                result[first] = [item]
            }
        }
        return result
    }
}

extension FriendsTableVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return litters.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsAndLitters[litters[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.tableView.dequeueReusableCell(withIdentifier: Constants.Cell.friend, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let newVC = cell as? FriendsTableViewCell {
            let friend = friendsAndLitters[litters[indexPath.section]]![indexPath.row]
            newVC.set(avatar: friend.avatar, name: friend.name, status: friend.status)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(litters[section])"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let newVC = Constants.Storyboard.photoFriend.instantiateInitialViewController() as? PhotoFriendVC {
            newVC.setId(id: friendsAndLitters[litters[indexPath.section]]![indexPath.row].id)
            self.navigationController?.pushViewController(newVC, animated: true)
        }
    }
}
