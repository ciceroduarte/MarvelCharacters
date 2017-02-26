//
//  MarvelCharactersUITests.swift
//  MarvelCharactersUITests
//
//  Created by Cicero on 15/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import XCTest

class MarvelCharactersUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCharacterList() {
        
        let app = XCUIApplication()
        app.collectionViews.cells.otherElements
            .containing(.staticText, identifier:"3-D Man")
            .children(matching: .image)
            .element
            .tap()

        app.navigationBars["3-D Man"].buttons["Back"].tap()
        
        let collectionView = app.otherElements
            .containing(.navigationBar, identifier:"MARVEL")
            .children(matching: .other)
            .element
            .children(matching: .other)
            .element
            .children(matching: .other)
            .element
            .children(matching: .collectionView)
            .element
        
        collectionView.swipeUp()
        collectionView.swipeUp()
        collectionView.swipeUp()
        collectionView.swipeUp()
    }
}
