//
//  HeroesCatalogLogic.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 05/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import Foundation

protocol HeroesCatalogRouterable: class {
    
}

protocol HeroesCatalogServable: class {
    
}

class HeroesCatalogLogic {
    
    private weak var router: HeroesCatalogRouterable?
    private let service: HeroesCatalogServable
    
    init(service: HeroesCatalogServable, router: HeroesCatalogRouterable?) {
        self.service = service
        self.router = router
    }
    
    convenience init(router: HeroesCatalogRouterable?) {
        self.init(service: MarvelAPI.shared.heroesService, router: router)
    }
}

extension MVLHeroesService: HeroesCatalogServable {
    
}
