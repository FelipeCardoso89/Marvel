//
//  ErrorViewModel.swift
//  marvelapp
//
//  Created by Felipe Antonio Cardoso on 13/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import Foundation

struct ErrorViewModel {
    let message: String
    let actionTitle: String?
    let action: (() -> Void)?
    
    init(message: String) {
        self.message = message
        self.actionTitle = nil
        self.action = nil
    }
    
    
    init(message: String, actionTitle: String?, action: (() -> Void)?) {
        self.message = message
        self.actionTitle = actionTitle
        self.action = action
    }
    
    init(error: NSError, actionTitle: String?, action: (() -> Void)?) {
        self.init(
            message: error.localizedDescription,
            actionTitle: actionTitle,
            action: action
        )
    }
}
