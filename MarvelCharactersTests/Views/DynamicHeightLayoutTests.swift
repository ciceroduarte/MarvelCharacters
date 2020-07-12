//
//  DynamicHeightLayoutTests.swift
//  MarvelCharactersTests
//
//  Created by Cícero Duarte da Silva on 11/07/20.
//  Copyright © 2020 ciceroduarte. All rights reserved.
//

import XCTest
@testable import MarvelCharacters

class DynamicHeightLayoutTests: XCTestCase {

    let sut = DynamicHeightLayout()

    func testCollectionViewContentSizeWithoutCollectionViewShouldReturnZero() {
        XCTAssertTrue(sut.collectionViewContentSize == .zero)
    }

    func testLayoutAttributesForElementsWithoutCollectionViewAndDelegateShouldReturnEmpty() {
        sut.prepare()

        let attributes = sut.layoutAttributesForElements(in: .zero)

        XCTAssertTrue(attributes?.isEmpty ?? false)
    }
}
