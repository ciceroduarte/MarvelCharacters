//
//  CharacterCellTests.swift
//  MarvelCharactersTests
//
//  Created by Cícero Duarte da Silva on 09/07/20.
//  Copyright © 2020 ciceroduarte. All rights reserved.
//

import XCTest
@testable import MarvelCharacters

class CharacterCellTests: XCTestCase {

    func testInitWithCoderShouldBeNil() {
        XCTAssertNil(CharacterCell(coder: NSCoder()))
    }
}
