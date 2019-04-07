//
//  CatalogCoordinator.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 05/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import Foundation

class CatalogCoordinator: NavigationCoordinator {
    
    private lazy var characterCatalogBuilder: CharacterCatalogBuilder = {
        return CharacterCatalogBuilder(router: self)
    }()
  
    func start() {
        viewController.setViewControllers([characterCatalogBuilder.build()], animated: true)
    }
    
}

extension CatalogCoordinator: CharacterCatalogRouterable {
    
    func detail(for character: Character) {
        viewController.pushViewController(CharacterDetailBuilder(router: self, character: character).build(), animated: true)
    }
}

extension CatalogCoordinator: CharacterDetailRouterable {
    
}
