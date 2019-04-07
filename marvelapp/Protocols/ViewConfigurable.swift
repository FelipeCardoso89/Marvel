//
//  ViewConfigurable.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 07/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import UIKit

protocol ViewConfigurable {
    associatedtype ViewModel
    func configure(with viewModel: ViewModel)
}
