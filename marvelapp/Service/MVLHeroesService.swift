//
//  MVLCharacterService.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 05/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import Foundation

typealias CharacterDataWrapperCompletionResult = ((Result<CharacterDataWrapper, NSError>) -> Void)
typealias CharacterDataWrapperResult = Result<CharacterDataWrapper, NSError>

typealias BooleanCompletionResult = ((Result<Bool, NSError>) -> Void)
typealias BooleanResult = Result<Void, NSError>


typealias CharacterOptionsCompletionResult = ((Result<CharacterOption, NSError>) -> Void)
typealias CharacterOptionsResult = Result<CharacterOption, NSError>

class MVLCharacterService {

    private let limit = 20
    
    private let baseURL: URL
    private let privateKey: String
    private let apiKey: String

    private var sharedSession: URLSession {
        return URLSession.shared
    }
    
    init(baseURL: URL, privateKey: String, apiKey: String) {
        self.baseURL = baseURL
        self.privateKey = privateKey
        self.apiKey = apiKey
    }

    func character(_ name: String?, page: Int, completion: @escaping CharacterDataWrapperCompletionResult) {
        
        print("Name: \(name ?? "NO NAME")")

        guard let path = Bundle.main.path(forResource: "CharacterMock", ofType: "json") else {
            completion(.failure(NSError(domain: "", code: 000, userInfo: ["message": "bla"])))
            return
        }

        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
            completion(.failure(NSError(domain: "", code: 000, userInfo: ["message": "bla"])))
            return
        }

        guard let response: CharacterDataWrapper = try? JSONDecoder().decode(CharacterDataWrapper.self, from: data) else {
            completion(.failure(NSError(domain: "", code: 000, userInfo: ["message": "bla"])))
            return
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            completion(.success(response))
        }
        
//        let timestamp = "\(Date().timeIntervalSince1970)"
//        let hash = "\(timestamp)\(privateKey)\(apiKey)".md5
//
//        var components = URLComponents(url: baseURL.appendingPathComponent("v1/public/characters"), resolvingAgainstBaseURL: true)
//
//        var customQueryItems = [URLQueryItem]()
//
//        if let name = name {
//            customQueryItems.append(URLQueryItem(name: "name", value: name))
//        }
//
//        if page > 0 {
//             customQueryItems.append(URLQueryItem(name: "offset", value: "\(page * limit)"))
//        }
//
//        let commonQueryItems = [
//            URLQueryItem(name: "ts", value: timestamp),
//            URLQueryItem(name: "hash", value: hash),
//            URLQueryItem(name: "apikey", value: apiKey)
//        ]
//
//        components?.queryItems = commonQueryItems + customQueryItems
//
//        guard let url = components?.url else {
//            completion(.failure(NSError(domain: "", code: 000, userInfo: ["message": "Can't build url"])))
//            return
//        }
//
//        let task = sharedSession.dataTask(with: url) { (data, response, error) in
//
//            if let error = error {
//                completion(.failure(NSError(domain: "", code: 000, userInfo: ["message": error.localizedDescription])))
//                return
//            }
//
//            guard let data = data else {
//                completion(.failure(NSError(domain: "", code: 000, userInfo: ["message": "Bla"])))
//                return
//            }
//
//            guard let characterData = try? JSONDecoder().decode(CharacterDataWrapper.self, from: data) else {
//                completion(.failure(NSError(domain: "", code: 000, userInfo: ["message": "Bla"])))
//                return
//            }
//
//            completion(.success(characterData))
//            return
//        }
//
//        task.resume()
    }
    
    func isFavorited(_ character: Character) -> Bool {
        if let id = character.id {
           return (UserDefaults.standard.object(forKey: "\(id)") as? Bool) ?? false
        } else {
            return false
        }
    }
    
    func favorite(_ character: Character) -> Bool {
        if let id = character.id {
            UserDefaults.standard.set(true, forKey: "\(id)")
            return isFavorited(character)
        } else {
            return false
        }
    }
    
    func unfavorite(_ character: Character) -> Bool {
        if let id = character.id {
            UserDefaults.standard.removeObject(forKey: "\(id)")
            return !isFavorited(character)
        } else {
            return true
        }
    }
}
