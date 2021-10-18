//
//  MainVC.swift
//  VK
//
//  Created by Андрей Шкундалёв on 20.09.21.
//

import UIKit

class MainVC: UIViewController, CAAnimationDelegate {

    @IBOutlet private weak var logoView: UIView!
    @IBOutlet private weak var loginTF: UITextField!
    @IBOutlet private weak var passwordTF: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    private var shape: CAShapeLayer! {
        didSet {
            shape.lineWidth = 10
            shape.strokeEnd = 0
            shape.strokeColor = UIColor.white.cgColor
            shape.lineCap = .round
            shape.fillColor = nil
        }
    }
    
    private var overShape: CAShapeLayer! {
        didSet {
            overShape.lineWidth = 10
            overShape.strokeEnd = 1
            overShape.strokeColor = UIColor.black.cgColor
            overShape.lineCap = .round
            overShape.fillColor = nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureScreen()
        addGesture()
        
        setupShape()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        subscribeToNotifications()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        unsubscribeFromNotification()
    }
    
    private func configureScreen() {
        
        self.logoView.layer.cornerRadius = 10
        self.loginButton.layer.cornerRadius = 5
        self.loginTF.placeholder = "Введите логин"
        self.passwordTF.placeholder = "Введите пароль"
        
        self.logoView.layer.shadowColor = UIColor.black.cgColor
        self.logoView.layer.shadowOffset = .zero
        self.logoView.layer.shadowRadius = 8
        self.logoView.layer.shadowOpacity = 0.8
    }
    
    private func addGesture() {

        let gesture = UITapGestureRecognizer(target: self, action: #selector(hadeKeyboard))
        self.scrollView.addGestureRecognizer(gesture)
    }

    @objc private func hadeKeyboard() {

        self.scrollView.endEditing(true)
    }
    
    private func subscribeToNotifications() {

        NotificationCenter.default.addObserver(self, selector: #selector(addScrolling), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(removeScroll), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func unsubscribeFromNotification() {

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    @objc private func addScrolling() {

        self.scrollView.contentInset.bottom = 120
    }

    @objc private func removeScroll() {

        self.scrollView.contentInset.bottom = 0
    }
    
    private func checkUserData() {
        
        if loginTF.text == "admin" && passwordTF.text == "root" {
            overShape.isHidden = false
            animate()
            loginTF.text = ""
            passwordTF.text = ""
        } else {
            showErrorData()
            loginTF.text = ""
            passwordTF.text = ""
        }
    }
    
    private func showMenu() {
        
        let storyaBoard = Constants.Storyboard.menu
        let vc = storyaBoard.instantiateInitialViewController()
        if let newVC = vc as? MenuTabBarVC {
            newVC.modalPresentationStyle = .fullScreen
            self.present(newVC, animated: true, completion: nil)
        }
    }
    
    private func showErrorData() {
        
        let alert = UIAlertController(title: "Ошибка", message: "Введены неверные данные", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction private func pressedLogin(_ sender: UIButton) {
        
        checkUserData()
    }
    
    private func setupShape() {
        shape = CAShapeLayer()
        overShape = CAShapeLayer()
        shape.frame = self.view.bounds
        overShape.frame = self.view.bounds
        let path = UIBezierPath()
        path.move(to: CGPoint(x: self.view.frame.size.width / 2 - 100, y: self.view.frame.size.height / 2 + 50))
        path.addLine(to: CGPoint(x: self.view.frame.size.width / 2 + 100, y: self.view.frame.size.height / 2 + 50))
        path.stroke()
        shape.path = path.cgPath
        overShape.path = path.cgPath
        self.view.layer.addSublayer(overShape)
        self.view.layer.addSublayer(shape)
        overShape.isHidden = true
    }
    
    private func animate() {
        let animate = CABasicAnimation(keyPath: "strokeEnd")
        animate.fromValue = 0
        animate.toValue = 1
        animate.duration = 2
        animate.delegate = self
        shape.add(animate, forKey: nil)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        showMenu()
        overShape.isHidden = true
    }
}

