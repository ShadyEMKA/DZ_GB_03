//
//  WebImageView.swift
//  VK
//
//  Created by Андрей Шкундалёв on 20.10.21.
//

import UIKit

class WebImageView: UIImageView {
    
    private var currentURL: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func set(urlString: String) {
        
        currentURL = urlString
        
        guard let url = URL(string: urlString) else { return }
        // проверка наличия изображения в кэш и загрузка из кэша, при наличии
        if let cashedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cashedResponse.data)
        }
        
        let session = URLSession(configuration: .default)
        DispatchQueue.global(qos: .userInteractive).async {
            session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                guard let data = data,
                let response = response else { return }
                
                DispatchQueue.main.async {
                    self.loadedToCashe(for: data, response: response)
                }
            }.resume()
        }
    }
    
    private func loadedToCashe(for data: Data, response: URLResponse) {
        guard let responseURL = response.url else { return }
        let cashedResponse = CachedURLResponse(response: response, data: data)
        // загрузка изображения в кэш
        URLCache.shared.storeCachedResponse(cashedResponse, for: URLRequest(url: responseURL))
        // проверка на загрузку нужного изображения при быстром скролле
        if responseURL.absoluteString == currentURL {
            self.image = UIImage(data: data)
        }
    }
}
