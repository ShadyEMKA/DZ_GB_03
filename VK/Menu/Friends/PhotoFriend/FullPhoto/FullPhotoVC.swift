//
//  FullPhotoVC.swift
//  VK
//
//  Created by Андрей Шкундалёв on 22.09.21.
//

import UIKit

class FullPhotoVC: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    
    var image: UIImage?
    var i = 0
    var user = User(name: "", avatar: nil, allPhoto: [nil])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = image
        self.imageView.contentMode = .scaleAspectFill
        
        swipePhoto()
        self.transitioningDelegate = self
    }
    
    @IBAction private func pressedShare(_ sender: Any) {
        
        let shareController = UIActivityViewController(activityItems: [self.imageView.image!], applicationActivities: nil)
        present(shareController, animated: true, completion: nil)
    }
    
    func swipePhoto() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipe(_:)))
        leftSwipe.direction = .left
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipe(_:)))
        rightSwipe.direction = .right
        self.imageView.addGestureRecognizer(leftSwipe)
        self.imageView.addGestureRecognizer(rightSwipe)
        self.imageView.isUserInteractionEnabled = true
    }
    
    @objc private func leftSwipe(_ sender: UISwipeGestureRecognizer) {
        if i < user.allPhoto.count - 1 {
            i += 1
            UIView.animate(withDuration: 0.25) {
                self.imageView.transform = .init(translationX: -self.view.frame.width, y: 0)
            } completion: { _ in
                self.imageView.transform = .identity
                self.imageView.transform = .init(translationX: self.view.frame.width, y: 0)
                self.imageView.image = self.user.allPhoto[self.i]
                UIView.animate(withDuration: 0.25) {
                    self.imageView.transform = .init(scaleX: 0.8, y: 0.8)
                } completion: { _ in
                    UIView.animate(withDuration: 0.5) {
                        self.imageView.transform = .identity
                    } completion: { _ in
                        return
                    }
                }
            }
        }

    }
    
    @objc private func rightSwipe(_ sender: UISwipeGestureRecognizer) {
        if i > 0 {
            i -= 1
            UIView.animate(withDuration: 0.25) {
                self.imageView.transform = .init(translationX: self.view.frame.width, y: 0)
            } completion: { _ in
                self.imageView.transform = .identity
                self.imageView.transform = .init(translationX: -self.view.frame.width, y: 0)
                self.imageView.image = self.user.allPhoto[self.i]
                UIView.animate(withDuration: 0.25) {
                    self.imageView.transform = .init(scaleX: 0.8, y: 0.8)
                } completion: { _ in
                    UIView.animate(withDuration: 0.5) {
                        self.imageView.transform = .identity
                    } completion: { _ in
                        return
                    }
                }
            }
        }
    }
}

extension FullPhotoVC: UIViewControllerTransitioningDelegate {
    
}
