//
//  CharacterDetailSection.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 06/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import Foundation

enum CharacterDetailSection {
    case main(viewModels: [CharacterDetailHeaderTableViewCellDTO])
    case comics(viewModels: [CharacterContentTableViewCellDTO])
    case events(viewModels: [CharacterContentTableViewCellDTO])
    case stories(viewModels: [CharacterContentTableViewCellDTO])
    case series(viewModels: [CharacterContentTableViewCellDTO])
}
 
extension CharacterDetailSection {
    
    var headerTitle: String?  {
        switch self {
        case .main:
            return nil
        case .comics:
            return "Comics"
        case .events:
            return "Events"
        case .stories:
            return "Stories"
        case .series:
            return "Series"
        }
    }
    
    var numberOfRows: Int {
        switch self {
        case let .main(viewModels):
            return viewModels.count
        case let .comics(viewModels),
             let .series(viewModels),
             let .stories(viewModels),
             let .events(viewModels):
            return viewModels.count
        }
    }
    
    var callToActionTitle: String {
        return preview ? "Show more" : "Show less"
    }
    
    var noContentMessageTitle: String {
        return "No content"
    }
    
    var numberOfPreviewItems: Int {
        return 3
    }
    
    var preview: Bool {
        return true
    }
    
    func viewModel(at row: Int) -> Any? {
        
        switch self {
        case let .main(viewModel):
            return viewModel[row]
            
        case let .comics(viewModels),
             let .series(viewModels),
             let .stories(viewModels),
             let .events(viewModels):
            return viewModels[row]
        }
    }
}
