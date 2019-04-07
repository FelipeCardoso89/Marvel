//
//  CharacterDetailSection.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 06/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import Foundation

enum CharacterDetailSection {
    case main(viewModels: [CharacterDetailHeaderTableViewCellDTO], preview: Bool)
    case comics(viewModels: [CharacterContentTableViewCellDTO], preview: Bool)
    case events(viewModels: [CharacterContentTableViewCellDTO], preview: Bool)
    case stories(viewModels: [CharacterContentTableViewCellDTO], preview: Bool)
    case series(viewModels: [CharacterContentTableViewCellDTO], preview: Bool)
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
        return viewModels.count
    }
    
    var viewModels: [Any] {
        switch self {
        case let .main(viewModels, _):
            return viewModels
        case let .comics(viewModels, _),
             let .series(viewModels, _),
             let .stories(viewModels, _),
             let .events(viewModels, _):
            return viewModels
        }
    }
    
    var callToActionTitle: String {
        return preview ? "Show more" : "Show less"
    }
    
    var noContentMessageTitle: String {
        switch self {
        case .main:
            return "No Character Information"
        case .comics:
            return "No Comics"
        case .events:
            return "No Events"
        case .stories:
            return "No Stories"
        case .series:
            return "No Series"
        }
    }
    
    var numberOfPreviewItems: Int {
        return 3
    }
    
    var preview: Bool {
        switch self {
        case let .main(_, preview),
             let .comics(_, preview),
             let .series(_, preview),
             let .stories(_, preview),
             let .events(_, preview):
            return preview
        }
    }
    
    func viewModel(at row: Int) -> Any? {
        
        switch self {
        case let .main(viewModel, _):
            return viewModel[row]
            
        case let .comics(viewModels, _),
             let .series(viewModels, _),
             let .stories(viewModels, _),
             let .events(viewModels, _):
            return viewModels[row]
        }
    }
}
