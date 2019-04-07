//
//  CharacterDetailSection.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 06/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import Foundation

enum CharacterDetailSection {
    case main(viewModel: CharacterDetailHeaderTableViewCellDTO)
    case comics
    case events
    case stories
    case series
}

extension CharacterDetailSection {
    
    var headerTitle: String?  {
        switch self {
        case .comics:
            return "Comics"
        case .events:
            return "Events"
        case .stories:
            return "Stories"
        case .series:
            return "Series"
        default:
            return nil
        }
    }
    
    var numberOfRows: Int {
        switch self {
        case .main:
            return 1
        default:
            return 0
        }
    }
    
}
