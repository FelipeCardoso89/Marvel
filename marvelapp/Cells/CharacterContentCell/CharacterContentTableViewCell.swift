//
//  CharacterContentTableViewCell.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 07/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import UIKit

class CharacterContentTableViewCell: UITableViewCell {
    @IBOutlet weak var contentImageView: NetworkImageLoader!
    @IBOutlet weak var titleLabel: UILabel!
}

extension CharacterContentTableViewCell: ViewConfigurable {
    
    typealias ViewModel = CharacterContentTableViewCellDTO
    
    func configure(with viewModel: CharacterContentTableViewCellDTO?) {
        titleLabel.text = viewModel?.title
        if let url = viewModel?.imageURL {
           contentImageView.loadImage(from: url)
        }
    }
}
