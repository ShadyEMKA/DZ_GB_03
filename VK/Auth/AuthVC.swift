//
//  AuthVC.swift
//  VK
//
//  Created by Андрей Шкундалёв on 20.09.21.
//

import UIKit
import WebKit

class AuthVC: UIViewController, CAAnimationDelegate {
    
    @IBOutlet weak private var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.navigationDelegate = self
        
        autorize()
    }
    
    private func autorize() {
        let url = configureURLForAutorize()
        loadWebView(from: url)
    }
    
    private func loadWebView(from url: URL?) {
        guard let url = url else { return }
        let request = URLRequest(url: url)
        self.webView.load(request)
    }
    
    private func configureURLForAutorize() -> URL? {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "oauth.vk.com"
        urlComponent.path = "/authorize"
        urlComponent.queryItems = [URLQueryItem(name: "client_id", value: "7978364"),
                                   URLQueryItem(name: "display", value: "mobile"),
                                   URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
                                   URLQueryItem(name: "scope", value: "262150"),
                                   URLQueryItem(name: "response_type", value: "token"),
                                   URLQueryItem(name: "v", value: "5.131")]
        return urlComponent.url
    }
    
    private func showMenu() {
        if Session.shared.token != nil {
            let newVC = UIStoryboard(name: "Menu", bundle: nil).instantiateInitialViewController() as! MenuTabBarVC
            SceneDelegate.shared().window?.rootViewController = newVC
        }
    }
}

extension AuthVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment else {
                  decisionHandler(.allow)
                  return
              }
        
        let params = fragment.components(separatedBy: "&").map { $0.components(separatedBy: "=") }.reduce([String: String]()) { result, param in
            var dict = result
            let key = param[0]
            let value = param[1]
            dict[key] = value
            return dict
        }
        
        guard let token = params["access_token"],
              let userId = params["user_id"] else { return }
        
        Session.shared.token = token
        Session.shared.userId = Int(userId)
        
        decisionHandler(.cancel)
        
        showMenu()
    }
}

