//
//  ComicTests.swift
//  MarvelCharacters
//
//  Created by Cicero on 02/03/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import Foundation

import XCTest
@testable import MarvelCharacters

class ComicTests: XCTestCase {
    
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
            "title": "cicero",
            "thumbnail": [
                "path": "http://www.google.com.br",
                "extension": "png"
            ]
            ] as [String : Any]
        return representation
    }
    
    // MARK: Tests
    func testInitializationWithNilValue() {
        XCTAssertNil(Comic(withRepresentation: nil))
    }
    
    func testInitializationWithRepresentation() {
        
        XCTAssertNotNil(Comic(withRepresentation: representation()))
    }
    
    func testInitializationWithInvalidImageRepresentation() {
        let representation = [
            "title": "cicero",
            "thumbnail": [
                "path": "path"
            ]
            ] as [String : Any]
        XCTAssertNil(Comic(withRepresentation: representation))
    }
    
    func testTitleAndThumbnail() {
        let comic = Comic(withRepresentation: representation())
        let url = URL(string: "http://www.google.com.br/standard_amazing.png")
        let portraitUrl = URL(string: "http://www.google.com.br/portrait_fantastic.png")
        
        XCTAssertTrue(comic?.title == "cicero")
        XCTAssertNotNil(comic?.image.url)
        XCTAssertTrue(comic?.image.url?.absoluteString == url?.absoluteString)
        XCTAssertTrue(comic?.image.portraitUrl?.absoluteString == portraitUrl?.absoluteString)
    }
}
