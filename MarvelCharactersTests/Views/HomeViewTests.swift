//
//  HomeViewTests.swift
//  MarvelCharactersTests
//
//  Created by Cícero Duarte da Silva on 10/07/20.
//  Copyright © 2020 ciceroduarte. All rights reserved.
//

import XCTest
@testable import MarvelCharacters

class HomeViewTests: XCTestCase {

    func testInitWithCoderShouldBeNil() {
        XCTAssertNil(HomeView(coder: NSCoder()))
    }
}
