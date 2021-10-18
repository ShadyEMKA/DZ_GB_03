//
//  FriendsTableViewCell.swift
//  VK
//
//  Created by Андрей Шкундалёв on 22.09.21.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    @IBOutlet private weak var avatarImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var shadowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureAvatar()
        animate()
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
    
    private func animate() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(animationAvatar))
        self.shadowView.addGestureRecognizer(gesture)
    }
    
    @objc private func animationAvatar() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.avatarImage.transform = .init(scaleX: 1.1, y: 1.1)
            self.shadowView.transform = .init(scaleX: 1.1, y: 1.1)
        } completion: { _ in
            UIView.animate(withDuration: 0.5) {
                self.avatarImage.transform = .init(scaleX: 1, y: 1)
                self.shadowView.transform = .init(scaleX: 1, y: 1)
            }
        }
    }
    
    func set(avatar: UIImage?, name: String) {
        self.avatarImage.image = avatar
        self.nameLabel.text = name
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
