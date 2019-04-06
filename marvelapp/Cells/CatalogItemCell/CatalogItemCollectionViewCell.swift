//
//  CatalogItemCollectionViewCell.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 05/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import UIKit
import PureLayout

class CatalogItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    private let gradientLayer: CAGradientLayer = CAGradientLayer()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView.newAutoLayout()
        indicator.style = UIActivityIndicatorView.Style.whiteLarge
        return indicator
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupGradient()
        setupCellLayout()
    }
    
    private func setupGradient() {
        gradientLayer.frame = gradientView.bounds
        gradientLayer.colors = [UIColor(white: 1.0, alpha: 0), UIColor.black.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.0, 0.9, 1.0]
        gradientView.layer.addSublayer(gradientLayer)
    }
    
    private func setupCellLayout() {
        clipsToBounds = true
        
        layer.cornerRadius = 8.0
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.4
        layer.masksToBounds = false
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8.0
        contentView.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(with dto: CatalogItemCollectionViewCellDTO?) {
        
        titleLabel.text = dto?.title
        
        if let url = dto?.imageURL {
            
            setupActivityIndicator()
            
            itemImageView.loadImage(from: url) { _ in
                DispatchQueue.main.async {
                    self.removeActivityIndicator()
                }
            }
        }
    }
    
}

private extension CatalogItemCollectionViewCell {
    
    private func setupActivityIndicator() {
        
        addSubview(activityIndicator)
        bringSubviewToFront(activityIndicator)
        
        activityIndicator.autoCenterInSuperview()
        activityIndicator.autoSetDimensions(to: CGSize(width: 22.0, height: 22.0))
        activityIndicator.startAnimating()
        
    }
    
    private func removeActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
    
}
