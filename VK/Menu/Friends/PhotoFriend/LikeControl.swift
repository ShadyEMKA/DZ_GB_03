//
//  LikeControl.swift
//  VK
//
//  Created by Андрей Шкундалёв on 22.09.21.
//

import UIKit

class LikeControl: UIControl {
    
    private var button: UIButton!
    private var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
    }
    
    private func configure() {
        addLabel()
        addButton()
        self.backgroundColor = .clear
    }
    
    private func addLabel() {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        label.textAlignment = .center
        self.label = label
        addSubview(label)
    }
    
    private func addButton() {
        let button = UIButton(frame: CGRect(x: 30, y: 0, width: 30, height: 30))
        let image = UIImage(named: "like")
        let newImage = image?.withRenderingMode(.alwaysTemplate)
        button.setImage(newImage, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(pressedButton), for: .touchUpInside)
        button.addTarget(self, action: #selector(animate), for: .touchUpInside)
        self.button = button
        addSubview(button)
    }
    
    @objc private func pressedButton() {
        if self.label.text == nil {
            self.label.text = "1"
            self.label.textColor = .red
            self.button.tintColor = .red
        } else {
            self.label.text = nil
            self.label.textColor = .white
            button.tintColor = .white
        }
    }
    
    @objc private func animate() {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut]) {
            self.button.transform = .init(scaleX: 1.1, y: 1.1)
        } completion: { _ in
            UIView.animate(withDuration: 0.2) {
                self.button.transform = .identity
            }
        }

    }
}
