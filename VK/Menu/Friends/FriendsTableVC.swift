//
//  FriendsTableVC.swift
//  VK
//
//  Created by Андрей Шкундалёв on 20.09.21.
//

import UIKit

class FriendsTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    private var littersButton: LittersControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        littersButton = LittersControl(frame: CGRect(x: self.view.frame.size.width - 30,
                                                     y: 150,
                                                     width: 20,
                                                     height: self.view.frame.size.height / 2 + 100))
        self.view.addSubview(littersButton)
        littersButton.delegate = self
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return litters.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedUsers[litters[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.tableView.dequeueReusableCell(withIdentifier: Constants.Cell.friend, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let newVC = cell as? FriendsTableViewCell {
            let user = sortedUsers[litters[indexPath.section]]![indexPath.row]
            newVC.set(avatar: user.avatar, name: user.name)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = Constants.Storyboard.photoFriend
        let vc =  storyBoard.instantiateInitialViewController()
        if let newVC = vc as? PhotoFriendCollectionVC {
            newVC.friend = sortedUsers[litters[indexPath.section]]![indexPath.row]
            self.navigationController?.pushViewController(newVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(litters[section])
    }
    
    func scroll(index: Int) {
        tableView.scrollToRow(at: IndexPath(row: 0, section: index), at: .top, animated: true)
    }
}

extension FriendsTableVC: LittersDelegate {
    func pressed(index: Int) {
        let indexPath = IndexPath(row: 0, section: index)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}

final class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        
        let frame = source.view.frame
        destination.view.frame = frame
        destination.view.transform = .init(translationX: frame.width, y: 0)
        
        UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
                                delay: 0,
                                options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.75) {
                let translation = CGAffineTransform(translationX: -frame.width, y: 0)
                let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                source.view.transform = translation.concatenating(scale)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.4) {
                let translation = CGAffineTransform(translationX: frame.width / 2, y: 0)
                let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                destination.view.transform = translation.concatenating(scale)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.4) {
                destination.view.transform = .identity
            }
        } completion: { finished in
            if finished && !transitionContext.transitionWasCancelled {
                source.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
}

final class CustomPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        
        let frame = source.view.frame
        destination.view.frame = frame
        destination.view.transform = .init(translationX: -frame.width, y: 0)
        
        UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),
                                delay: 0,
                                options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.75) {
                let translation = CGAffineTransform(translationX: frame.width / 2, y: 0)
                let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                source.view.transform = translation.concatenating(scale)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.4) {
                let translation = CGAffineTransform(translationX: frame.width, y: 0)
                let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                source.view.transform = translation.concatenating(scale)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.4) {
                destination.view.transform = .identity
            }
        } completion: { finished in
            if finished && !transitionContext.transitionWasCancelled {
                source.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
}

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return CustomPushAnimator()
        } else if operation == .pop {
            return CustomPopAnimator()
        }
        return nil
    }
}
