//
//  CharacterDetailTableViewCell.swift
//  
//
//  Created by Felipe Antonio Cardoso on 07/04/19.
//

import UIKit

class CharacterDetailHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private let gradientLayer: CAGradientLayer = CAGradientLayer()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupGradient()
    }
    
    private func setupGradient() {
        gradientLayer.frame = gradientView.bounds
        gradientLayer.colors = [UIColor(white: 1.0, alpha: 0), UIColor.black.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.0, 0.9, 1.0]
        gradientView.layer.addSublayer(gradientLayer)
    }
}

extension CharacterDetailHeaderTableViewCell: ViewConfigurable {
    
    typealias ViewModel = CharacterDetailHeaderTableViewCellDTO
    
    func configure(with viewModel: CharacterDetailHeaderTableViewCellDTO?) {
        
        titleLabel.text = viewModel?.title
        
        if !(viewModel?.description?.isEmpty ?? true) {
            descriptionLabel.text = viewModel?.description ?? "No description"
        } else {
            descriptionLabel.text = "No description"
        }
        
        if let url = viewModel?.imageURL {
            headerImageView.loadImage(from: url)
        }
    }
}