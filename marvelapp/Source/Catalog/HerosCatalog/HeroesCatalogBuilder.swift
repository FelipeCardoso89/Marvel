//
//  HeroesCatalogBuilder.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 05/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import Foundation

class HeroesCatalogBuilder {
    
    private weak var router: HeroesCatalogRouterable?
    
    init(router: HeroesCatalogRouterable) {
        self.router = router
    }
    
    func build() -> HeroesCatalogViewController {
        let logic = HeroesCatalogLogic(router: router)
        let viewModel = HeroesCatalogViewModel(logic: logic)
        return HeroesCatalogViewController(viewModel: viewModel)
    }
    
}
