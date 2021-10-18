//
//  ProfileVC.swift
//  VK
//
//  Created by Андрей Шкундалёв on 20.09.21.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet private weak var avatarImage: UIImageView!
    @IBOutlet private weak var shadowView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButtonExit()
        configureAvatar()
    }
    
    private func configureAvatar() {
        self.avatarImage.image = UIImage(named: "my")
        self.avatarImage.contentMode = .scaleAspectFill
        self.avatarImage.layer.cornerRadius = self.avatarImage.frame.width / 2
        
        self.shadowView.layer.cornerRadius = self.shadowView.frame.width / 2
        self.shadowView.layer.shadowColor = UIColor.black.cgColor
        self.shadowView.layer.shadowOffset = .zero
        self.shadowView.layer.shadowRadius = 5
        self.shadowView.layer.shadowOpacity = 0.8
        
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
    
    private func addButtonExit() {
        let exitButton = UIBarButtonItem(image: UIImage(systemName: "arrow.uturn.backward"), style: .done, target: self, action: #selector(exit))
        exitButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = exitButton
    }
    
    @objc private func exit() {
        let alert = UIAlertController(title: "Выйти из аккаунта", message: "Вы уверены?", preferredStyle: .alert)
        let actionYes = UIAlertAction(title: "Да", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        let actionNo = UIAlertAction(title: "Нет", style: .default, handler: nil)
        alert.addAction(actionYes)
        alert.addAction(actionNo)
        present(alert, animated: true, completion: nil)
    }

}
