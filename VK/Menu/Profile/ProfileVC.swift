//
//  ProfileVC.swift
//  VK
//
//  Created by Андрей Шкундалёв on 20.09.21.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet private weak var avatarImage: WebImageView!
    @IBOutlet private weak var shadowView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countFriendsLabel: UILabel!
    @IBOutlet weak var countGroupsLabel: UILabel!
    @IBOutlet weak var countPhotoLabel: UILabel!
    
    private let fetcher = NetworkDataFetcher()
    private var user: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAvatar()
        loadingUser()
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
        fetcher.getUsers { user in
            self.user = UserModel(name: user.fullName,
                                  avatar: user.photo200,
                                  countFriends: user.counters.friends,
                                  coumtGroups: user.counters.groups,
                                  countPhoto: user.counters.photos)
            self.configure()
            }
        }
    
    private func configure() {
        guard let user = user else {
            return }
        self.avatarImage.set(urlString: user.avatar)
        self.nameLabel.text = user.name
        self.countFriendsLabel.text = String(user.countFriends)
        self.countGroupsLabel.text = String(user.coumtGroups)
        self.countPhotoLabel.text = String(user.countPhoto)
    }
}
