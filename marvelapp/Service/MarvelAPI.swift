//
//  MarvelAPI.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 05/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import Foundation

class MarvelAPI {
    
    static let shared = MarvelAPI()

    var heroesService: MVLHeroesService {
        return MVLHeroesService.shared
    }
    
}
