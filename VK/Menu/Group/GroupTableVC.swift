//
//  GroupTableVC.swift
//  VK
//
//  Created by Андрей Шкундалёв on 20.09.21.
//

import UIKit

class GroupTableVC: UITableViewController {
    
    var groups: [Group] = [Group(name: "GeekBrains", avatar: UIImage(named: "GB"))]
    
    private var filteredGroup: [Group] = []
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltered: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        addButtonSearch()
        configureSearchController()
    }
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltered {
            return filteredGroup.count
        }
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCell(withIdentifier: Constants.Cell.group, for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let newVC = cell as? GroupTableViewCell {
            let group: Group
            if isFiltered {
                group = filteredGroup[indexPath.row]
            } else {
                group = groups[indexPath.row]
            }
            newVC.set(avatar: group.avatar, name: group.name)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        default:
            break
        }
    }
    
    private func addButtonSearch() {
        let button = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .done, target: self, action: #selector(pressedSearch))
        button.tintColor = .black
        self.navigationItem.rightBarButtonItem = button
    }
    
    @objc private func pressedSearch() {
        let storyBoard = Constants.Storyboard.searchGroup
        let vc = storyBoard.instantiateInitialViewController()
        if let newVC = vc as? SearchGroupTableVC {
            newVC.title = "Поиск"
            self.navigationController?.pushViewController(newVC, animated: true)
        }
    }
}

extension GroupTableVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredGroup = groups.filter() { value in
            value.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
}

