//
//  NetworkManager.swift
//  VK
//
//  Created by Андрей Шкундалёв on 20.10.21.
//

import UIKit

final class NetworkManager {
    
    private let token = Session.shared.token
    
    func getRequest(from path: String, param: [String: String], completion: @escaping (Data?, Error?) -> Void) {
        
        guard let url = urlConfigure(from: path, param: param) else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }.resume()
    }
    
    private func urlConfigure(from path: String, param: [String: String]) -> URL? {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = API.scheme
        urlComponents.host = API.host
        urlComponents.path = path
        
        var allParam = param
        allParam["v"] = API.version
        guard let token = token else { return nil }
        allParam["access_token"] = token
        urlComponents.queryItems = allParam.compactMap({ key, value in
            URLQueryItem(name: key, value: value)
        })
        return urlComponents.url
    }
}
