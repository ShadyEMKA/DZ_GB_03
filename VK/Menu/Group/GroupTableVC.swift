//
//  GroupTableVC.swift
//  VK
//
//  Created by Андрей Шкундалёв on 20.09.21.
//

import UIKit
import RealmSwift

class GroupTableVC: UITableViewController {
    
    private let fetcher = NetworkDataFetcher()
    private let localeDataManager = LocaleDataManager()
    private var groups: Results<GroupModel>!
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateGroupsLocale()
    }
    
    private func configure() {
        
        tableView.addSubview(refreshControlGroup)
        tableView.separatorStyle = .none
        tableView.contentInset.top = CGFloat(10)
        
        navigationController?.hidesBarsOnSwipe = true
        navigationItem.titleView = titleView
    }
    
    @objc private func refresh() {
        
        loadingGroups()
    }
    
    private func updateGroupsLocale() {
        self.groups = localeDataManager.load(type: GroupModel.self)
        refreshControlGroup.endRefreshing()
        tableView.reloadData()
    }
}

// MARK: - Loading groups from the network and saving to the database

extension GroupTableVC {
    
    private func loadingGroups() {
        
        fetcher.getGroups { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                let groupsBD = response.items.compactMap { GroupModel(value: [$0.name, $0.photo100, $0.id]) }
                if let oldGroupsBD = self.groups {
                    self.localeDataManager.delete(object: oldGroupsBD)
                }
                self.localeDataManager.save(object: groupsBD)
                self.updateGroupsLocale()
            }
        }
    }
}

// MARK: - UITableViewDataSource and UITableViewDelegate

extension GroupTableVC {
    
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

extension GroupTableVC: SearchTextFieldDelegate, UISearchControllerDelegate {
    
    func didChangeSearch(_ text: String?) {
        
        guard let text = text else { return }
        
        isFiltred = text != "" ? true : false
        
        fetcher.getGroupsSearch(from: text, completion: { [weak self] groups in
            self?.filtredGroups = groups.items.compactMap({ group in
                GroupModel(value: [group.name, group.photo100])
            })
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.refreshControlGroup.endRefreshing()
            }
        })
    }
}

