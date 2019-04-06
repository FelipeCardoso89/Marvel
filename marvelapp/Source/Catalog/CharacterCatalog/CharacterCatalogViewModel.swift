//
//  CharacterCatalogViewModel.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 05/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import Foundation

protocol CharacterCatalogViewModelDelegate: class {
    func didFinsihLoad()
    func didFinsihLoad(with error: NSError)
}

class CharacterCatalogViewModel {
    
    private let logic: CharacterCatalogLogic
    
    private var characterData: CharacterDataWrapper?
    
    weak var delegate: CharacterCatalogViewModelDelegate?
    
    private var characters: [Character] {
        return characterData?.data?.results ?? []
    }
    
    var numberOfCharacters: Int {
        return characters.count
    }
    
    init(logic: CharacterCatalogLogic) {
        self.logic = logic
    }
    
    func loadCharacters() {
        
        logic.characters { (result) in
            switch result {
            case let .success(characters):
                self.characterData = characters
                self.delegate?.didFinsihLoad()
            case let .failure(error):
                self.delegate?.didFinsihLoad(with: error)
            }
        }
    }
    
    func character(at indexPath: IndexPath) -> Character? {
        return (indexPath.row < characters.count) ? characters[indexPath.row] : nil
    }
}
