//
//  DetailViewTests.swift
//  MarvelCharactersTests
//
//  Created by Cícero Duarte da Silva on 11/07/20.
//  Copyright © 2020 ciceroduarte. All rights reserved.
//

import XCTest
@testable import MarvelCharacters

class DetailViewTests: XCTestCase {

    func testInitWithCoderShouldBeNil() {
        XCTAssertNil(DetailView(coder: NSCoder()))
    }
}
