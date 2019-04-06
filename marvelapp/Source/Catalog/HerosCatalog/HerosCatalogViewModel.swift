//
//  CharacterCatalogViewModel.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 05/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import Foundation

protocol CharacterCatalogViewModelDelegate: class {
    func didLoadCharacteres()
}

class CharacterCatalogViewModel {
    
    private let logic: CharacterCatalogLogic
    
    private var characterData: CharacterDataWrapper?
    
    weak var delegate: CharacterCatalogViewModelDelegate?
    
    var numberOfCharacters: Int {
        return (characterData?.data?.results ?? [Character]()).count
    }
    
    init(logic: CharacterCatalogLogic) {
        self.logic = logic
    }
    
    func loadCharacters() {
        
        logic.characters { (result) in
            switch result {
            case let .success(characters):
                self.characterData = characters
                self.delegate?.didLoadCharacteres()
            case let .failure(error):
                print("\(error)")
            }
        }
    }
    
    func catalogItemDTO(for indexPath: IndexPath) -> CatalogItemCollectionViewCellDTO? {
        
        guard let character = character(at: indexPath) else {
            return nil
        }
        
        return CatalogItemCollectionViewCellDTO(character: character)
    }
    
    func character(at indexPath: IndexPath) -> Character? {
        
        guard let character = characterData?.data?.results else {
            return nil
        }
        
        return character[indexPath.row]
    }
}


private extension CatalogItemCollectionViewCellDTO {
    
    init(character: Character) {
        self.title = character.name
        self.imageURL = nil
    }
    
}
