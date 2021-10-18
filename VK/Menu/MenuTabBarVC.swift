//
//  MenuTabBarVC.swift
//  VK
//
//  Created by Андрей Шкундалёв on 20.09.21.
//

import UIKit

class MenuTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
    }
    
    private func configureTabBar() {
        self.tabBar.tintColor = .black
        self.tabBar.unselectedItemTintColor = .gray
        
        self.tabBar.layer.shadowColor = UIColor.black.cgColor
        self.tabBar.layer.shadowOpacity = 1
        self.tabBar.layer.shadowRadius = 5
        self.tabBar.layer.shadowOffset = .zero
    }
  
}
