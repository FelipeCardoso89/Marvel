//
//  CatalogItemCollectionViewCellDTO.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 05/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import Foundation

struct CatalogItemCollectionViewCellDTO {
    let title: String?
    let imageURL: URL?
}

extension CatalogItemCollectionViewCellDTO {
    init(character: Character) {
        self.title = character.name
        self.imageURL = character.thumbnail?.url
    }
}

