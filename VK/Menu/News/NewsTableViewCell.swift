//
//  NewsTableViewCell.swift
//  VK
//
//  Created by Андрей Шкундалёв on 24.09.21.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet private weak var avatarView: UIImageView!
    @IBOutlet private weak var postImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarView.layer.cornerRadius = avatarView.frame.size.height / 2
    }
    
}
