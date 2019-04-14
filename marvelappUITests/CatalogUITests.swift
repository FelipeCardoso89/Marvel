//
//  CatalogUITests.swift
//  CatalogUITests
//
//  Created by Felipe Antonio Cardoso on 05/04/2019.
//  Copyright © 2019 Felipe Antonio Cardoso. All rights reserved.
//

import XCTest
import Quick
import Nimble
import UITestHelper

class CatalogUITests: QuickSpec {
    
    private let timeout: TimeInterval = 5
    private let characterName: String = "Abyss"
    
    override func spec() {
        
        beforeEach {
            self.tryLaunch([LaunchArguments.mockNetworkResponses])
        }
        
        describe("catalog screen") {
            
            it("can see data") {

                CommunUITests.app(self.app, waitForCollectionViewWith: self.timeout)
                self.checkIfCharactersWasReloaded(timeout: self.timeout)
                self.waitForSearchField(timeout: self.timeout)
            }

            it("can search a item", closure: {
                CommunUITests.app(self.app, waitForCollectionViewWith: self.timeout)
                self.searchFor(text: self.characterName)
                self.checkIfIsThereCatalogItemCellWith(title: self.characterName)
            })

            it("can see error message for not found item", closure: {
                
                CommunUITests.app(self.app, waitForCollectionViewWith: self.timeout)
                self.searchFor(text: "Iron hulk")
                
                let errorAlert = self.app.alerts.element(boundBy: 0)
                errorAlert.waitUntilExists(self.timeout)
                expect(errorAlert.exists).to(beTrue())
                expect(errorAlert.label).to(equal("Not Found"))
                errorAlert.buttons["OK"].tap()
                
                let cancelButton = self.app.buttons["Cancel"]
                cancelButton.waitUntilExists(self.timeout)
                expect(cancelButton.exists).to(beTrue())
                cancelButton.tap()
                
                self.resetSearch(timeout: self.timeout)
                
                CommunUITests.app(self.app, waitForCollectionViewWith: self.timeout)
                self.checkIfCharactersWasReloaded(timeout: self.timeout)
            })

            it("can reset from search", closure: {

                CommunUITests.app(self.app, waitForCollectionViewWith: self.timeout)
                self.searchFor(text: self.characterName)
                self.checkIfIsThereCatalogItemCellWith(title: self.characterName)

                self.app.buttons["Cancel"].tap()

                self.resetSearch(timeout: self.timeout)

                CommunUITests.app(self.app, waitForCollectionViewWith: self.timeout)
                self.checkIfCharactersWasReloaded(timeout: self.timeout)
            })

            it("can favorite and unfavorite a item from the catalog", closure: {

                CommunUITests.app(self.app, waitForCollectionViewWith: self.timeout)

                self.longPressAt(self.app.cells.element(boundBy: 2), pressWith: 2.0)
                var actionSheet = self.waitForOptionsAlertController(timeout: self.timeout)
                self.selectFavoriteAction(from: actionSheet, inTimeout: self.timeout)

                self.longPressAt(self.app.cells.element(boundBy: 2), pressWith: 2.0)
                actionSheet = self.waitForOptionsAlertController(timeout: self.timeout)
                self.selectUnfavoriteAction(from: actionSheet, inTimeout: self.timeout)

                self.longPressAt(self.app.cells.element(boundBy: 2), pressWith: 2.0)
                actionSheet = self.waitForOptionsAlertController(timeout: self.timeout)

                let favoriteAction = actionSheet.buttons["Favorite"]
                favoriteAction.waitUntilExists(self.timeout)
                expect(favoriteAction.exists).to(beTrue())

                let cancelAction = actionSheet.buttons["Cancel"]
                cancelAction.tap()

                expect(actionSheet.exists).to(beFalse())
            })

            it("can see item details", closure: {

                CommunUITests.app(self.app, waitForCollectionViewWith: self.timeout)

                let selectedCell = self.app.cells.element(boundBy: 2)
                selectedCell.tap()

                let detailTableView = self.app.tables["character_detail_table_view"]
                detailTableView.waitUntilExists(self.timeout)
                expect(detailTableView.exists).to(beTrue())

                let headerCell = detailTableView.cells["character_detail_header_cell"]
                headerCell.waitUntilExists(self.timeout)
                expect(headerCell.exists).to(beTrue())
            })
            
            
        }
    }
}


extension CatalogUITests {
    
    private func waitForSearchField(timeout: TimeInterval) {
        let searchField = self.app.searchFields.element
        searchField.waitUntilExists(timeout)
        expect(searchField.exists).to(beTrue())
    }
    
    private func waitForOptionsAlertController(timeout: TimeInterval) -> XCUIElement {
        let actionSheet = self.app.sheets.element(boundBy: 0)
        actionSheet.waitUntilExists(timeout)
        expect(actionSheet.exists).to(beTrue())
        return actionSheet
    }
    
    private func selectFavoriteAction(from actionSheet: XCUIElement, inTimeout timeout: TimeInterval) {
        let favoriteAction = actionSheet.buttons["Favorite"]
        favoriteAction.waitUntilExists(timeout)
        expect(favoriteAction.exists).to(beTrue())
        favoriteAction.tap()
    }
    
    private func selectUnfavoriteAction(from actionSheet: XCUIElement, inTimeout timeout: TimeInterval) {
        let favoriteAction = actionSheet.buttons["Remove from favorites"]
        favoriteAction.waitUntilExists(timeout)
        expect(favoriteAction.exists).to(beTrue())
        favoriteAction.tap()
    }
    
    private func searchFor(text: String) {
        let searchField = self.app.searchFields.element
        searchField.tap()
        searchField.typeText(text)
        self.app.buttons["Search"].tap()
    }
    
    private func checkIfIsThereCatalogItemCellWith(title: String) {
        let label = self.app.staticTexts["catalog_item_cell_title_label"]
        let imageView = self.app.images["catalog_item_cell_image_view"]
        
        expect(imageView.exists).to(beTrue())
        expect(label.exists).to(beTrue())
        expect(label.label).to(equal(title))
    }
    
    private func resetSearch(timeout: TimeInterval) {
        let resetButtom = app.buttons["Reset"]
        resetButtom.waitUntilExists(timeout)
        expect(resetButtom.exists).to(beTrue())
        resetButtom.tap()
    }
    
    private func checkIfCharactersWasReloaded(timeout: TimeInterval) {
        expect(self.app.staticTexts["catalog_item_cell_title_label"].exists).to(beTrue())
        expect(self.app.images["catalog_item_cell_image_view"].exists).to(beTrue())
        expect(self.app.collectionViews["catalog_collection_view"].cells.count).notTo(equal(0))
    }
    
    private func longPressAt(_ element: XCUIElement, pressWith duration: TimeInterval) {
        expect(element.exists).to(beTrue())
        element.press(forDuration: duration)
    }
}

extension XCUIElement {
    func scrollToElement(element: XCUIElement) {
        while !element.visible() {
            swipeUp()
        }
    }
    
    func visible() -> Bool {
        guard self.exists && !self.frame.isEmpty else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(self.frame)
    }
}
