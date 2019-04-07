//
//  MessageTableViewCell.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 07/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
}

extension MessageTableViewCell: ViewConfigurable {
    
    typealias ViewModel = MessageTableViewCellDTO
    
    func configure(with viewModel: MessageTableViewCellDTO?) {
        titleLabel.text = viewModel?.title
    }
    
}
