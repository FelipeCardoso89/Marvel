//
//  ViewController.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 05/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import Foundation
import UIKit

class ViewController<ViewType: UIView>: UIViewController, ViewConfiguration {
    
    var customView: ViewType {
        return view as! ViewType
    }
    
    override func loadView() {
        let newView: ViewType = makeView(with: ViewType.self)
        newView.backgroundColor = .white
        view = newView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
    
    private func makeView<ViewType: UIView>(with type: ViewType.Type) -> ViewType {
        return ViewType()
    }
    
    func buildViewHierarchy() {}
    func setupConstraints() {}
    func configureViews() {}
}


