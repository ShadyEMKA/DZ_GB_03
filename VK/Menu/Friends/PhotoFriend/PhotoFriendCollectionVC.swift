//
//  PhotoFriendCollectionVC.swift
//  VK
//
//  Created by Андрей Шкундалёв on 22.09.21.
//

import UIKit

class PhotoFriendCollectionVC: UICollectionViewController {
    
    var friend = User(name: "", avatar: nil, allPhoto: [nil])

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    private func configure() {
        self.navigationItem.title = "Все фото"
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  
        return friend.allPhoto.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Cell.photoFriend , for: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if let object = cell as? PhotoFriendCollectionViewCell {
            let friend = friend.allPhoto
            object.set(image: friend[indexPath.item])
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = Constants.Storyboard.fullPhoto
        let vc = storyBoard.instantiateInitialViewController()
        if let newVC = vc as? FullPhotoVC {
            let photo = friend.allPhoto
            newVC.image = photo[indexPath.item]
            newVC.user = friend
            newVC.i = indexPath.item
            newVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(newVC, animated: true)
        }
    }
}

extension PhotoFriendCollectionVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let countItem: CGFloat = 2
        let paddingWidth = 20 * (countItem + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthForItem = availableWidth / countItem
        return CGSize(width: widthForItem, height: widthForItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
}
