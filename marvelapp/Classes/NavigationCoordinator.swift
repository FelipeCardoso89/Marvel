//
//  NavigationCoordinator.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 05/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import UIKit

class NavigationCoordinator: Coordinatable {    
    var childCoordinators = [Coordinatable]()
    var viewController = UINavigationController()
}

extension NavigationCoordinator: AlertControllerPresentable {}

extension Coordinatable where Self: NavigationCoordinator {
    
    var rootViewController: UIViewController {
        return viewController
    }
    
    func start() {
        fatalError("Implement in child")
    }
    
    func stop() {
        fatalError("Implement in child")
    }
}
