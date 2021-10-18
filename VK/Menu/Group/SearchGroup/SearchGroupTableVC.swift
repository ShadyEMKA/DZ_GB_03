//
//  SearchGroupTableVC.swift
//  VK
//
//  Created by Андрей Шкундалёв on 22.09.21.
//

import UIKit

class SearchGroupTableVC: UITableViewController {
    
    var groupSearch: [Group] = [Group(name: "VK", avatar: UIImage(named: "vk"))]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return groupSearch.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCell(withIdentifier: Constants.Cell.searchGroup, for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let newVC = cell as? SearchGroupTableViewCell {
            let object = groupSearch[indexPath.row]
            newVC.set(image: object.avatar, name: object.name)
        }
    }
}
