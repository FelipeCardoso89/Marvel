//
//  CommunUITests.swift
//  marvelappUITests
//
//  Created by Felipe Antonio Cardoso on 14/04/19.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import Foundation

import XCTest
import Quick
import Nimble
import UITestHelper

class CommunUITests: QuickSpec {
    
    static func app(_ app: XCUIApplication, waitForCollectionViewWith timeout: TimeInterval) {
        app.collectionViews["catalog_collection_view"].waitUntilExists(timeout)
        app.cells["catalog_item_cell"].waitUntilExists(timeout)
    }
    
}
