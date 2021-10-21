//
//  TitleView.swift
//  VK
//
//  Created by Андрей Шкундалёв on 20.10.21.
//

import UIKit

class TitleView: UIView {
    
    let searchView = SearchTextField()
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(searchView)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func addConstraints() {
        
        searchView.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        searchView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
        searchView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4).isActive = true
        searchView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4).isActive = true
    }
}
