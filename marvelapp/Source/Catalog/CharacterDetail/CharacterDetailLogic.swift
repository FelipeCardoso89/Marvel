//
//  CharacterDetailLogic.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 06/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import Foundation

protocol CharacterDetailRouterable: class {
    func showOptions(_ options: [CharacterOption], for character: Character, onSelectedOption: @escaping ((CharacterOption) -> Void))
    func showAlert(with title: String, message: String, retry: (()->Void)?, onDismiss: (()->Void)?)
}

protocol CharacterDetailServable: class {
    func isFavorited(_ character: Character) -> Bool
    func favorite(_ character: Character) -> Bool
    func unfavorite(_ character: Character) -> Bool
}

class CharacterDetailLogic {
    
    private weak var router: CharacterDetailRouterable?
    private let service: CharacterDetailServable
    
    init(service: CharacterDetailServable, router: CharacterDetailRouterable?) {
        self.service = service
        self.router = router
    }
    
    convenience init(router: CharacterDetailRouterable?) {
        self.init(service: MarvelAPI.shared.characterService, router: router)
    }
    
    func showOptionsFor(character: Character, completion: @escaping CharacterOptionsCompletionResult) {
        
        guard let router = router else {
            completion(.failure(NSError(domain: "", code: 001, userInfo: ["message": "Can't show options"])))
            return
        }
        
        let options = CharacterOption.allCases.filter { (option) -> Bool in
            switch option {
            case .favorite:
                return !self.service.isFavorited(character)
            case .unfavorite:
                return self.service.isFavorited(character)
            }
        }
        
        router.showOptions(options, for: character) { (option) in
            completion(.success(option))
        }
    }
}

extension CharacterDetailLogic {
    
    func isFavorite(character: Character) -> Bool {
        return service.isFavorited(character)
    }
    
    func favorite(_ character: Character, completion: @escaping BooleanCompletionResult) {
        completion(.success(self.service.favorite(character)))
    }
    
    func unfavorite(_ character: Character, completion: @escaping BooleanCompletionResult) {
        completion(.success(self.service.unfavorite(character)))
    }
    
}


extension MVLCharacterService: CharacterDetailServable {
    
}

