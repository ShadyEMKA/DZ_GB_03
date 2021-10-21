//
//  SearchTextField.swift
//  VK
//
//  Created by Андрей Шкундалёв on 20.10.21.
//

import UIKit

protocol SearchTextFieldDelegate: AnyObject {
    func didChangeSearch(_ text: String?)
}

class SearchTextField: UITextField {
    
    weak var dataSource: SearchTextFieldDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(displayP3Red: 215/255, green: 220/255, blue: 217/255, alpha: 1)
        font = UIFont.systemFont(ofSize: 14)
        borderStyle = .none
        clipsToBounds = true
        layer.cornerRadius = 15
        placeholder = "Поиск..."
        clearButtonMode = .whileEditing
        delegate = self
        
        let image = UIImage(named: "search")
        leftView = UIImageView(image: image)
        leftView?.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        leftViewMode = .always
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    // смещение картинки "лупа"
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.leftViewRect(forBounds: bounds)
        return rect.offsetBy(dx: 10, dy: 0)
    }
    // смещение text
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.offsetBy(dx: 10, dy: 0)
    }
    // смещение для кнопки clear
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.clearButtonRect(forBounds: bounds)
        return rect.offsetBy(dx: -10, dy: 0)
    }
}

extension SearchTextField: UITextFieldDelegate {
    // вызов при вводе текста
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.dataSource?.didChangeSearch(textField.text)
    }
}
