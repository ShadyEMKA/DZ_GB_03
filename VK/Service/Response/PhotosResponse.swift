//
//  PhotosResponse.swift
//  VK
//
//  Created by Андрей Шкундалёв on 25.10.21.
//

import Foundation

struct PhotosResponseWrapped: Decodable {
    
    let response: PhotosResponse
}

struct PhotosResponse: Decodable {
    
    let count: Int
    let items: [Photos]
}

struct Photos: Decodable {
    
    let sizes: [Photo]
}

struct Photo: Decodable {
    
    let type: String
    let url: String
}
