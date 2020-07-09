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

    var comic: Comic? {
        return DecodableHelper.decode(Comic.self, dictionary: representation())
    }

    func testInitializationWithRepresentation() {
        XCTAssertNotNil(comic)
    }

    func testInitializationWithInvalidImageRepresentation() {
        let representation = [
            "title": "cicero",
            "thumbnail": [
                "path": "path"
            ]
            ] as [String: Any]
        XCTAssertNil(DecodableHelper.decode(Comic.self, dictionary: representation))
    }

    func testTitleAndThumbnail() throws {
        let comic = try XCTUnwrap(self.comic)
        let url = URL(string: "http://www.google.com.br/standard_amazing.png")
        let portraitUrl = URL(string: "http://www.google.com.br/portrait_fantastic.png")

        XCTAssertTrue(comic.title == "cicero")
        XCTAssertNotNil(comic.thumbnail.url)
        XCTAssertTrue(comic.thumbnail.url?.absoluteString == url?.absoluteString)
        XCTAssertTrue(comic.thumbnail.portraitUrl?.absoluteString == portraitUrl?.absoluteString)
    }

    private func representation() -> [String: Any] {
        let representation = [
            "title": "cicero",
            "thumbnail": [
                "path": "http://www.google.com.br",
                "extension": "png"
            ]
            ] as [String: Any]
        return representation
    }
}
