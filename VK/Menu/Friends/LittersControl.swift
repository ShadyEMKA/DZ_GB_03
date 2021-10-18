//
//  LittersControl.swift
//  VK
//
//  Created by Андрей Шкундалёв on 27.09.21.
//

import UIKit

protocol LittersDelegate {
    func pressed(index: Int)
}

class LittersControl: UIStackView {
    
    private var arrayButtons: [UIButton] = []
    
    var delegate: LittersDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setButton()
        configure()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        setButton()
        configure()
    }
    
    private func configure() {
        self.axis = .vertical
        self.distribution = .equalSpacing
    }
    
    private func setButton() {
        for i in litters {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: 20).isActive = true
            button.heightAnchor.constraint(equalToConstant: 20).isActive = true
            button.setTitle(String(i), for: .normal)
            button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 15)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .black
            button.layer.cornerRadius = 10
            button.clipsToBounds = true
            button.addTarget(self, action: #selector(litterPressed(_:)), for: .touchUpInside)
            addArrangedSubview(button)
            arrayButtons.append(button)
        }
    }
    
    @objc func litterPressed(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.4) {
            sender.transform = .init(scaleX: 1.3, y: 1.3)
        } completion: { _ in
            sender.transform = .init(scaleX: 1, y: 1)
        }

        if self.delegate != nil {
            for (index, button) in arrayButtons.enumerated() {
                if sender == button {
                    self.delegate?.pressed(index: index)
                }
            }
        }
    }
}
