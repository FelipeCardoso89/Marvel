//
//  AppCoordinator.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 05/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import Foundation

class AppCoordinator: Coordinator {
    
    private lazy var catalogCoordinator: CatalogCoordinator = {
        let coordinator = CatalogCoordinator()
        return coordinator
    }()
    
    override init() {
        super.init()
        super.viewController = catalogCoordinator.rootViewController
    }
    
    func start() {
        catalogCoordinator.start()
    }
    
    func stop() {
        
    }
}
