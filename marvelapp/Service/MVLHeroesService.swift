//
//  MVLCharacterService.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 05/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import Foundation
import RxSwift

typealias CharacterDataWrapperCompletionResult = ((Result<CharacterDataWrapper, NSError>) -> Void)
typealias CharacterDataWrapperResult = Result<CharacterDataWrapper, NSError>

class MVLCharacterService {
    
    private let baseURL: URL
    private let apiKey: String
    
    private var sharedSession: URLSession {
        return URLSession.shared
    }
    
    init(baseURL: URL, apiKey: String) {
        self.baseURL = baseURL
        self.apiKey = apiKey
    }
    
    func characters(completion: @escaping CharacterDataWrapperCompletionResult) {
        
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completion(.success(response))
        }
        
        
//        let url = baseURL.appendingPathComponent("v1/public/characters?apikey=\(apiKey)")
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
}
