//
//  ActionTableViewCell.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 07/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import UIKit

class ActionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var actionTitle: UILabel!
    
}


extension ActionTableViewCell: ViewConfigurable {
    
    typealias ViewModel = ActionTableViewCellDTO
    
    func configure(with viewModel: ActionTableViewCellDTO?) {
        actionTitle.text = viewModel?.actionTitle
    }
    
}

