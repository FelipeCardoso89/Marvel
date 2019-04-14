//
//  MVLHeroesMockService.swift
//  marvelappTests
//
//  Created by Felipe Antonio Cardoso on 07/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import Foundation
import UITestHelper

class MVLHeroesMockService {
    
    static let shared = MVLHeroesMockService()
    
    private var favorites = [String: Bool]()
    
}

extension MVLHeroesMockService: CharacterCatalogServable {
    
    func character(_ name: String?, page: Int, completion: @escaping CharacterDataWrapperCompletionResult) {
        
        
        var filename: String = "CharacterDataWrapper"
        
        if let searchName = name {
            filename = (searchName.elementsEqual("Abyss")) ? "SingleCharacterDataWrapper" : "EmptyCharacterDataWrapper"
        }
        
        guard let path = Bundle(for: type(of: self)).path(forResource: filename, ofType: "json") else {
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
        
        completion(.success(response))
    }
    
    func isFavorited(_ character: Character) -> Bool {
        
        guard let characterId = character.id else {
            return false
        }
        
        return favorites["\(characterId)"] ?? false
    }
    
    func favorite(_ character: Character) -> Bool {
        
        guard let characterId = character.id else {
            return false
        }
        
        favorites.updateValue(true, forKey: "\(characterId)")
        return true
    }
    
    func unfavorite(_ character: Character) -> Bool {
        
        guard let characterId = character.id else {
            return false
        }
        
        favorites.removeValue(forKey: "\(characterId)")
        return true
    }
    
}


