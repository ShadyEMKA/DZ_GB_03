//
//  ProfileVC.swift
//  VK
//
//  Created by Андрей Шкундалёв on 20.09.21.
//

import UIKit
import RealmSwift

class ProfileVC: UIViewController {

    @IBOutlet private weak var avatarImage: WebImageView!
    @IBOutlet private weak var shadowView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countFriendsLabel: UILabel!
    @IBOutlet weak var countGroupsLabel: UILabel!
    @IBOutlet weak var countPhotoLabel: UILabel!
    
    private let localeDataManager = LocaleDataManager()
    private let fetcher = NetworkDataFetcher()
    private var userLocale: Results<UserModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAvatar()
        loadingUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUserLocale()
    }
    
    private func configureAvatar() {
        self.avatarImage.contentMode = .scaleAspectFill
        self.avatarImage.layer.cornerRadius = self.avatarImage.frame.width / 2
        self.shadowView.layer.cornerRadius = self.shadowView.frame.width / 2
        
        self.shadowView.layer.shadowColor = UIColor.black.cgColor
        self.shadowView.layer.shadowOffset = .zero
        self.shadowView.layer.shadowRadius = 5
        self.shadowView.layer.shadowOpacity = 0.8
    }
    
    private func loadingUser() {
        fetcher.getUsers { [weak self] user in
            guard let self = self else { return }
            let user = UserModel(value: [user.fullName, user.photo200, user.counters.friends, user.counters.groups, user.counters.photos])
            DispatchQueue.main.async {
                self.localeDataManager.save(object: user)
                self.updateUserLocale()
            }
            }
        }
    
    private func updateUserLocale() {
        self.userLocale = localeDataManager.load(type: UserModel.self)
        guard let user = userLocale.first else { return }
        configure(for: user)
    }
    
    private func configure(for user: UserModel) {
        self.avatarImage.set(urlString: user.avatar)
        self.nameLabel.text = user.name
        self.countFriendsLabel.text = String(user.countFriends)
        self.countGroupsLabel.text = String(user.coumtGroups)
        self.countPhotoLabel.text = String(user.countPhoto)
    }
}
