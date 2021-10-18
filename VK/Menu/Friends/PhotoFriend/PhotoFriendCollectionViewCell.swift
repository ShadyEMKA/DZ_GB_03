//
//  PhotoFriendCollectionViewCell.swift
//  VK
//
//  Created by Андрей Шкундалёв on 22.09.21.
//

import UIKit

class PhotoFriendCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var photoView: UIImageView!
    
    func set(image: UIImage?) {
        self.photoView.image = image
        self.photoView.contentMode = .scaleAspectFill
    }
}
