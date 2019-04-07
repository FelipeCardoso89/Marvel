//
//  CharacterDetailViewModel.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 06/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import Foundation

class CharacterDetailViewModel {
    
    private let logic: CharacterDetailLogic
    private let character: Character
    private var sections = [CharacterDetailSection]()
    
    var numberOfSections: Int {
        return sections.count
    }
    
    init(logic: CharacterDetailLogic, character: Character) {
        self.logic = logic
        self.character = character
    }
    
    func loadCharacterData() {
        
        sections.append(.main(viewModel: CharacterDetailHeaderTableViewCellDTO(
            title: character.name,
            description: character.description,
            imageURL: character.thumbnail?.url
        )))
        
    }
    
    func numberOfRows(at section: Int) -> Int {
        return sections[section].numberOfRows
    }
    
    func section(at indexPath: IndexPath) -> CharacterDetailSection {
        return sections[indexPath.section]
    }
    
    func titleForHeader(at section: Int) -> String? {
        return sections[section].headerTitle
    }
}
