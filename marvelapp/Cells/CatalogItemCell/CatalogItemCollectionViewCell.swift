//
//  CatalogItemCollectionViewCell.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 05/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import UIKit

class CatalogItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(with dto: CatalogItemCollectionViewCellDTO?) {
        titleLabel.text = dto?.title
        itemImageView.image = nil
    }
    
}
