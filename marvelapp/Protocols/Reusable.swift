//
//  Reusable.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 05/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import UIKit

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UIView: Reusable {}
extension Reusable where Self: UIView {
    func nib<T: UIView>(_ type: T.Type, bundle: Bundle? = nil) -> UINib {
        return UINib(nibName: type.reuseIdentifier, bundle: bundle)
    }
}

extension Reusable where Self: UICollectionView {
    
    func registerCell<T: UICollectionViewCell>(of type: T.Type, bundle: Bundle? = nil) {
        register(nib(type, bundle: bundle), forCellWithReuseIdentifier: type.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(withReuseIdentifier: type.reuseIdentifier, for: indexPath) as? T {
            return cell
        } else {
            return T()
        }
    }
}

extension Reusable where Self: UITableView {
    
    func registerCell<T: UITableViewCell>(of type: T.Type, bundle: Bundle? = nil) {
        register(nib(type, bundle: bundle), forCellReuseIdentifier: type.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(withIdentifier: type.reuseIdentifier, for: indexPath) as? T {
            return cell
        } else {
            return T(style: .default, reuseIdentifier: T.reuseIdentifier)
        }
    }
}

extension UIViewController: Reusable {}
extension Reusable where Self: UIViewController {
    
    static func loadXib(from bundle: Bundle?) -> Self {
        return Self(nibName: Self.reuseIdentifier, bundle: bundle)
    }
    
}
