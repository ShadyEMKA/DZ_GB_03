//
//  SearchGroupTableViewCell.swift
//  VK
//
//  Created by Андрей Шкундалёв on 22.09.21.
//

import UIKit

class SearchGroupTableViewCell: UITableViewCell {

    @IBOutlet private weak var avatarImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var shadowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureAvatar()
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
    
    func set(image: UIImage?, name: String) {
        
        self.avatarImage.image = image
        self.nameLabel.text = name
    }

}
