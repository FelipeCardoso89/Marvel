//
//  CharacterCatalogLogic.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 05/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import Foundation

protocol CharacterCatalogRouterable: class {
    
}

protocol CharacterCatalogServable: class {
    func characters(at page: Int, completion: @escaping CharacterDataWrapperCompletionResult)
}

class CharacterCatalogLogic {
    
    private weak var router: CharacterCatalogRouterable?
    private let service: CharacterCatalogServable
    
    init(service: CharacterCatalogServable, router: CharacterCatalogRouterable?) {
        self.service = service
        self.router = router
    }
    
    convenience init(router: CharacterCatalogRouterable?) {
        self.init(service: MarvelAPI.shared.characterService, router: router)
    }
    
    func characters(at page: Int, completion: @escaping CharacterDataWrapperCompletionResult) {
        service.characters(at: page, completion: completion)
    }
    
}

extension MVLCharacterService: CharacterCatalogServable {
    
}
