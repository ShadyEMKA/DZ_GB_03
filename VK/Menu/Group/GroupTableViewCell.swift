//
//  GroupTableViewCell.swift
//  VK
//
//  Created by Андрей Шкундалёв on 22.09.21.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    @IBOutlet private weak var avatarImage: WebImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var shadowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        self.avatarImage.contentMode = .scaleAspectFill
    }
    
    override func layoutSubviews() {
        
        self.avatarImage.layer.cornerRadius = self.avatarImage.frame.width / 2
        self.shadowView.layer.cornerRadius = self.shadowView.frame.width / 2
        self.shadowView.layer.shadowColor = UIColor.black.cgColor
        self.shadowView.layer.shadowOffset = .zero
        self.shadowView.layer.shadowRadius = 5
        self.shadowView.layer.shadowOpacity = 0.8
    }
    
    func set(avatar: String, name: String) {
        
        self.avatarImage.set(urlString: avatar)
        self.nameLabel.text = name
    }

}
