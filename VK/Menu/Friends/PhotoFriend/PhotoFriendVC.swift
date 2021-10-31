//
//  PhotoFriendVC.swift
//  VK
//
//  Created by Андрей Шкундалёв on 25.10.21.
//

import UIKit

class PhotoFriendVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var photos = [String]()
    private var idFriend: Int?
    
    private let fetcher = NetworkDataFetcher()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        loadingPhotos()
    }
    
    func setId(id: Int) {
        
        idFriend = id
    }
    
    private func loadingPhotos() {
        
        guard let id = idFriend else { return }
        fetcher.getPhotos(from: id) { [weak self] response in
            self?.photos = response.items.compactMap({ photos in
                return photos.sizes[2].url
            })
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

extension PhotoFriendVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Cell.photoFriend, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if let cell = cell as? PhotoFriendCVCell {
            cell.set(imageString: photos[indexPath.item])
        }
    }
}

extension PhotoFriendVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let countColumns: CGFloat = 2
        let paddingWidth = 20 * (countColumns + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthForItem = availableWidth / countColumns
        return CGSize(width: widthForItem, height: widthForItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
}
