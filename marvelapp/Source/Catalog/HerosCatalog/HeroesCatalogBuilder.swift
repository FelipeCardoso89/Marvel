//
//  CharacterCatalogBuilder.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 05/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import Foundation

class CharacterCatalogBuilder {
    
    private weak var router: CharacterCatalogRouterable?
    
    init(router: CharacterCatalogRouterable) {
        self.router = router
    }
    
    func build() -> CharacterCatalogViewController {
        let logic = CharacterCatalogLogic(router: router)
        let viewModel = CharacterCatalogViewModel(logic: logic)
        return CharacterCatalogViewController(viewModel: viewModel)
    }
    
}
