//
//  NetworkDataFetcher.swift
//  VK
//
//  Created by Андрей Шкундалёв on 20.10.21.
//

import UIKit

final class NetworkDataFetcher {
    
    private let networkManager = NetworkManager()
    
    func getFriends(completion: @escaping (FriendsResponse) -> Void) {
        
        let param = ["fields":"nickname,photo_100,online,id", "order": "name"]
        networkManager.getRequest(from: API.friendsGet, param: param) { data, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let decode = self.decodeJSON(type: FriendsResponseWrapped.self, data: data) else { return }
            completion(decode.response)
        }
    }
    
    func getGroups(completion: @escaping (GroupsResponse) -> Void) {

        let param = ["extended": "1"]
        networkManager.getRequest(from: API.groupsGet, param: param) { data, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let decode = self.decodeJSON(type: GroupsResponseWrapped.self, data: data) else { return }
            completion(decode.response)
        }
    }
    
    func getUsers(completion: @escaping (UsersResponse) -> Void) {

        let param = ["fields": "photo_200,counters"]
        networkManager.getRequest(from: API.usersGet, param: param) { data, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let decode = self.decodeJSON(type: UsersResponseWrapped.self, data: data) else { return }
            completion(decode.response.first!)
        }
    }
    
    func getGroupsSearch(from text: String, completion: @escaping (GroupsResponse) -> Void) {
        
        let param = ["q": text, "count": "50"]
        networkManager.getRequest(from: API.groupsSearch, param: param) { data, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let decode = self.decodeJSON(type: GroupsResponseWrapped.self, data: data) else { return }
            completion(decode.response)
        }
    }
    
    func getPhotos(from userId: Int, completion: @escaping (PhotosResponse) -> Void) {
        
        let param = ["owner_id": String(userId), "album_id": "profile", "rev": "1"]
        networkManager.getRequest(from: API.photosGet, param: param) { data, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let decode = self.decodeJSON(type: PhotosResponseWrapped.self, data: data) else { return }
            completion(decode.response)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, data: Data?) -> T? {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = data,
              let decode = try? decoder.decode(type.self, from: data) else { return nil }
        return decode
    }
}
