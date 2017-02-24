//
//  CharacterTests.swift
//  MarvelCharacters
//
//  Created by Cicero on 16/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import Foundation

import XCTest
@testable import MarvelCharacters

class CharacterTests: XCTestCase {
    
    // MARK: ivars
    
    // MARK: Life Cycle
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Private methods
    private func representation() -> [String: Any] {
        let representation = [
            "name": "cicero",
            "description": "description",
            "thumbnail": [
                "path": "http://www.google.com.br",
                "extension": "png"
            ]
        ] as [String : Any]
        return representation
    }
    
    // MARK: Tests
    func testInitializationWithNilValue() {
        XCTAssertNil(Character(withRepresentation: nil))
    }
    
    func testInitializationWithRepresentation() {
        
        XCTAssertNotNil(Character(withRepresentation: representation()))
    }
    
    func testInitializationWithInvalidImageRepresentation() {
        let representation = [
            "name": "cicero",
            "description": "oi",
            "thumbnail": [
                "path": "path"
            ]
        ] as [String : Any]
        XCTAssertNil(Character(withRepresentation: representation))
    }
    
    func testNameDescriptionAndThumbnail() {
        let character = Character(withRepresentation: representation())
        let url = URL(string: "http://www.google.com.br/standard_large.png")
        
        XCTAssertTrue(character?.name == "cicero")
        XCTAssertTrue(character?.characterDescription == "description")
        XCTAssertNotNil(character?.image?.url)
        XCTAssertTrue(character?.image?.url?.absoluteString == url?.absoluteString)
    }
}
