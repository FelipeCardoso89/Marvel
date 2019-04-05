//
//  CatalogCoordinator.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 05/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import Foundation

class CatalogCoordinator: NavigationCoordinator {
    
    private lazy var heroesCatalogBuilder: HeroesCatalogBuilder = {
        return HeroesCatalogBuilder(router: self)
    }()
    
    func start() {
        viewController.setViewControllers([heroesCatalogBuilder.build()], animated: true)
    }
    
}

extension CatalogCoordinator: HeroesCatalogRouterable {
    
}
