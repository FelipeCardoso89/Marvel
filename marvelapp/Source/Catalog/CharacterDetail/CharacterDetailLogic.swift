//
//  CharacterDetailLogic.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 06/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import Foundation

protocol CharacterDetailRouterable: class {
    
}

protocol CharacterDetailServable: class {
    
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
    
}

extension MVLCharacterService: CharacterDetailServable {
    
}

