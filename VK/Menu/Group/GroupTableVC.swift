//
//  GroupTableVC.swift
//  VK
//
//  Created by Андрей Шкундалёв on 20.09.21.
//

import UIKit

class GroupTableVC: UITableViewController {
    
    private let fetcher = NetworkDataFetcher()
    private var groups = [GroupModel]()
    private var filtredGroups = [GroupModel]()
    private var isFiltred: Bool = false
    
    lazy private var refreshControlGroup: UIRefreshControl = {
        let refreshControlGroup = UIRefreshControl()
        refreshControlGroup.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControlGroup
    }()
    
    lazy private var titleView: TitleView = {
        let titleView = TitleView()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.searchView.dataSource = self
        return titleView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        loadingGroups()
    }
    
    private func configure() {
        
        tableView.addSubview(refreshControlGroup)
        tableView.separatorStyle = .none
        tableView.contentInset.top = CGFloat(10)
        
        navigationController?.hidesBarsOnSwipe = true
        navigationItem.titleView = titleView
    }
    
    private func loadingGroups() {
        
        fetcher.getGroups { response in
            self.groups = response.items.compactMap({ group in
                GroupModel(name: group.name, avatar: group.photo100)
            })
            self.tableView.reloadData()
        }
        refreshControlGroup.endRefreshing()
    }
    
    @objc private func refresh() {
        
        loadingGroups()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltred {
            return filtredGroups.count
        }
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCell(withIdentifier: Constants.Cell.group, for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let newVC = cell as? GroupTableViewCell {
            let group = isFiltred ? filtredGroups[indexPath.row] : groups[indexPath.row]
            newVC.set(avatar: group.avatar, name: group.name)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if isFiltred {
            return "Найдено групп - \(filtredGroups.count)"
        }
        return "Всего групп - \(groups.count)"
    }
}

extension GroupTableVC: SearchTextFieldDelegate {
    
    func didChangeSearch(_ text: String?) {
        
        guard let text = text else { return }
        
        fetcher.getGroupsSearch(from: text, completion: { groups in
            self.filtredGroups = groups.items.compactMap({ group in
                GroupModel(name: group.name, avatar: group.photo100)
            })
        })
        
        isFiltred = text != "" ? true : false
        tableView.reloadData()
    }
}

