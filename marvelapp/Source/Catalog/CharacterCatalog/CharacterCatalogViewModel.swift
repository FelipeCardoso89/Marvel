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
    
    private var characterData: CharacterDataWrapper? {
        didSet (newValue) { characters.append(contentsOf: characterData?.data?.results ?? []) }
    }
    
    weak var delegate: CharacterCatalogViewModelDelegate?
    
    private var characters = [Character]()
    
    private var currentPage: Int = -1
    
    var numberOfCharacters: Int {
        return characters.count
    }
    
    init(logic: CharacterCatalogLogic) {
        self.logic = logic
    }
    
    func loadCharacters() {
        loadCharacters(at: 0)
    }
    
    func loadNextPage() {
        loadCharacters(at: currentPage + 1)
    }
    
    func character(at indexPath: IndexPath) -> Character? {
        return (indexPath.row < characters.count) ? characters[indexPath.row] : nil
    }
    
    private func loadCharacters(at page: Int) {
        
        guard currentPage != page else {
            return
        }
        
        logic.characters(at: page) { (result) in
            switch result {
            case let .success(characterData):
                self.currentPage = page
                self.characterData = characterData
                self.delegate?.didFinsihLoad()
            case let .failure(error):
                self.delegate?.didFinsihLoad(with: error)
            }
        }
    }
}
