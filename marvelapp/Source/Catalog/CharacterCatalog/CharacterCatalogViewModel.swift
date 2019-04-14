//
//  CharacterCatalogViewModel.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 05/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import Foundation

protocol CharacterCatalogViewModelDelegate: class {
    func willStartLoad()
    func willFinsihLoad()
    func didFinsihLoad()
    func didFinsihLoad(with error: NSError)
}

class CharacterCatalogViewModel {
    
    private let logic: CharacterCatalogLogic
    
    weak var delegate: CharacterCatalogViewModelDelegate?
    
    private var characters = [Character]()
    
    private var characterData: CharacterDataWrapper? {
        didSet { self.didUpdateCharacterData() }
    }
    
    private let itemsPerPage: Int = 20
    private var currentPage: Int = -1
    private var currentName: String?
    
    var numberOfCharacters: Int {
        return characters.count
    }
    
    var title: String {
        return "Characters"
    }
    
    var isFirstLoad: Bool {
        return currentPage == -1
    }
    
    var isSearching: Bool {
        return !(currentName?.isEmpty ?? true)
    }
    
    init(logic: CharacterCatalogLogic) {
        self.logic = logic
    }
    
    func loadCharacters() {
        
        guard isFirstLoad else {
            return
        }
        
        loadCharacters(at: 0)
    }
    
    func loadNextPage() {
        loadCharacters(name: currentName, at: (currentPage + 1))
    }
    
    func reload() {
        reset()
        loadCharacters()
    }
    
    func reset() {
        currentPage = -1
        currentName = nil
        characterData = nil
    }
    
    func character(at indexPath: IndexPath) -> Character? {
        return (indexPath.row < characters.count) ? characters[indexPath.item] : nil
    }
    
    func viewModel(at indexPath: IndexPath) -> Any? {
    
        guard let character = character(at: indexPath) else {
            return nil
        }
        
        return CatalogItemCollectionViewCellDTO(character: character, favorited: logic.isFavorite(character: character))
    }
    
    func detailForCharacter(at indexPath: IndexPath) {
    
        guard let character = character(at: indexPath) else {
            return
        }
        
        logic.showDetail(of: character)
    }
    
    func optionsForCharacter(at indexPath: IndexPath, completion: (() -> Void)? = nil) {
        
        guard let character = character(at: indexPath) else {
            return
        }
        
        logic.showOptionsFor(character: character) { (result) in
            
            guard case let .success(option) = result else {
                return
            }
            
            switch option {
            case .favorite:
                self.logic.favorite(character, completion: { _ in
                    completion?()
                })
            case .unfavorite:
                self.logic.unfavorite(character, completion: { _ in
                    completion?()
                })
                break
            }
        }
    }
    
    func searchCharacter(with name: String) {
        currentName = name
        loadCharacters(name: currentName, at: 0)
    }
    
    private func didUpdateCharacterData() {
        
        if currentPage >= 1 {
            characters.append(contentsOf: characterData?.data?.results ?? [])
        } else {
            characters = characterData?.data?.results ?? []
        }
        
    }
    
    private func loadCharacters(name: String? = nil, at page: Int) {
        
        guard self.currentPage != page else {
            return
        }
        
        delegate?.willStartLoad()
        logic.character(with: name, at: page) { (result) in
            
            self.delegate?.willFinsihLoad()
            
            switch result {
            case let .success(characterData):
                self.currentPage = page
                self.currentName = name
                self.characterData = characterData
                
                if (self.characters.isEmpty && (self.currentPage == 0)) {
                    self.logic.showAlert(
                        with: "Not Found",
                        message: "Can't find any character with name: \(name ?? "NO NAME").",
                        retry: nil,
                        onDismiss: nil
                    )
                } else {
                    self.delegate?.didFinsihLoad()
                }
                
            case let .failure(error):
                
                if self.isFirstLoad {
                    self.delegate?.didFinsihLoad(with: error)
                } else {
                    DispatchQueue.main.async {
                        self.logic.showError(error: error, retry: nil, onDismiss: nil)
                    }
                }
            }
        }
    }
}
