//
//  CharacterOptions.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 07/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import Foundation

enum CharacterOption: CaseIterable {
    case favorite
    case unfavorite
}

extension CharacterOption {
    
    var title: String {
        switch self {
        case .favorite:
            return "Favorite"
        case .unfavorite:
            return "Remove from favorites"
        }
    }
    
}
