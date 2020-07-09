//
//  SerieCellTests.swift
//  MarvelCharactersTests
//
//  Created by Cícero Duarte da Silva on 09/07/20.
//  Copyright © 2020 ciceroduarte. All rights reserved.
//

import XCTest
@testable import MarvelCharacters

class SerieCellTests: XCTestCase {

    func testInitWithFrameShouldInitializeViews() {
        let serieCell = SerieCell(frame: .zero)

        XCTAssertTrue(serieCell.name.font.pointSize == 16)
        XCTAssertTrue(serieCell.image.clipsToBounds)
    }

    func testInitWithCoderShouldBeNil() {
        XCTAssertNil(SerieCell(coder: NSCoder()))
    }
}
