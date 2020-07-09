//
//  SerieTests.swift
//  MarvelCharacters
//
//  Created by Cicero on 02/03/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import Foundation

import XCTest
@testable import MarvelCharacters

class SerieTests: XCTestCase {

    var serie: Serie? {
        return DecodableHelper.decode(Serie.self, dictionary: representation())
    }

    func testInitializationWithRepresentation() {
        XCTAssertNotNil(serie)
    }

    func testInitializationWithInvalidImageRepresentation() {
        let representation = [
            "title": "cicero",
            "thumbnail": [
                "path": "path"
            ]
            ] as [String: Any]

        XCTAssertNil(DecodableHelper.decode(Serie.self, dictionary: representation))
    }

    func testTitleAndThumbnail() throws {
        let serie = try XCTUnwrap(self.serie)
        let url = URL(string: "http://www.google.com.br/standard_amazing.png")
        let portraitUrl = URL(string: "http://www.google.com.br/portrait_fantastic.png")

        XCTAssertTrue(serie.title == "cicero")
        XCTAssertNotNil(serie.thumbnail.url)
        XCTAssertTrue(serie.thumbnail.url?.absoluteString == url?.absoluteString)
        XCTAssertTrue(serie.thumbnail.portraitUrl?.absoluteString == portraitUrl?.absoluteString)
    }

    private func representation() -> [String: Any] {
        return [
            "title": "cicero",
            "thumbnail": [
                "path": "http://www.google.com.br",
                "extension": "png"
            ]
        ] as [String: Any]
    }
}
