//
//  PhotoFriendCVCell.swift
//  VK
//
//  Created by Андрей Шкундалёв on 25.10.21.
//

import UIKit

class PhotoFriendCVCell: UICollectionViewCell {
    
    @IBOutlet weak var photoView: WebImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        
        photoView.image = nil
    }
    
    func set(imageString: String) {
        
        photoView.set(urlString: imageString)
    }
    
    
}
