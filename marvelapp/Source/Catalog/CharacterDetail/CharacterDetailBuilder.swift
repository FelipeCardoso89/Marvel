//
//  CharacterDetailBuilder.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 06/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import Foundation

class CharacterDetailBuilder {
    
    private weak var router: CharacterDetailRouterable?
    
    var character: Character
    
    init(router: CharacterDetailRouterable, character: Character) {
        self.router = router
        self.character = character
    }
    
    func build() -> CharacterDetailViewController {
        let logic = CharacterDetailLogic(router: router)
        let viewModel = CharacterDetailViewModel(logic: logic, character: character)
        return CharacterDetailViewController(viewModel: viewModel)
    }
    
}
