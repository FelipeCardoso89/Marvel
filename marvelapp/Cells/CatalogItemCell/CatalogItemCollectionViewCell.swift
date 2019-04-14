//
//  CatalogItemCollectionViewCell.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 05/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import UIKit
import PureLayout

protocol CatalogItemCollectionViewCellDelegate: class {
    func longPressCell(at indexPath: IndexPath)
}

class CatalogItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImageView: NetworkImageLoader!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    private let gradientLayer: CAGradientLayer = CAGradientLayer()
    private var favorited: Bool = false
    
    weak var delegate: CatalogItemCollectionViewCellDelegate?
    
    var indexPath: IndexPath? = nil
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView.newAutoLayout()
        indicator.style = UIActivityIndicatorView.Style.whiteLarge
        return indicator
    }()
    
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(didLongPressCell))
        gesture.minimumPressDuration = 0.5
        gesture.cancelsTouchesInView = true
        return gesture
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        gradientView.addGestureRecognizer(longPressGesture)
    }
    
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
        layer.borderColor = favorited ? UIColor.yellow.cgColor : UIColor.clear.cgColor
        layer.borderWidth = favorited ? 8.0 : 0.0

        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8.0
        contentView.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(with dto: CatalogItemCollectionViewCellDTO?) {
        
        favorited = dto?.favorited ?? false
        titleLabel.text = dto?.title
        
        guard let url = dto?.imageURL else {
            return
        }
        
        setupActivityIndicator()
        
        itemImageView.loadImage(from: url) { _ in
            DispatchQueue.main.async {
                self.removeActivityIndicator()
            }
        }
    }
    
    @objc func didLongPressCell() {
        
        if (longPressGesture.state != UIGestureRecognizer.State.began){
            return
        }
        
        if let indexPath = indexPath {
            delegate?.longPressCell(at: indexPath)
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
