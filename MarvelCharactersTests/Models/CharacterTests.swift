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

    var character: Character? {
        return DecodableHelper.decode(Character.self, dictionary: representation())
    }

    func testInitializationWithRepresentation() {
        XCTAssertNotNil(character)
    }

    func testInitializationWithInvalidImageRepresentation() {
        let representation = [
            "name": "cicero",
            "description": "oi",
            "thumbnail": [
                "path": "path"
            ]
        ] as [String: Any]

        XCTAssertNil(DecodableHelper.decode(Character.self, dictionary: representation))
    }

    func testNameDescriptionAndThumbnail() throws {
        let character = try XCTUnwrap(self.character)
        let url = URL(string: "http://www.google.com.br/standard_amazing.png")
        let portraitUrl = URL(string: "http://www.google.com.br/portrait_fantastic.png")

        XCTAssertTrue(character.name == "cicero")
        XCTAssertTrue(character.characterDescription == "description")
        XCTAssertNotNil(character.thumbnail.url)
        XCTAssertTrue(character.thumbnail.url?.absoluteString == url?.absoluteString)
        XCTAssertTrue(character.thumbnail.portraitUrl?.absoluteString == portraitUrl?.absoluteString)
    }

    private func representation() -> [String: Any] {
        let representation = [
            "name": "cicero",
            "description": "description",
            "comics": [
                "collectionURI": "http://www.google.com.br",
                "available": 1
            ],
            "series": [
                "collectionURI": "http://www.google.com.br",
                "available": 1
            ],
            "thumbnail": [
                "path": "http://www.google.com.br",
                "extension": "png"
            ]
        ] as [String: Any]
        return representation
    }
}
