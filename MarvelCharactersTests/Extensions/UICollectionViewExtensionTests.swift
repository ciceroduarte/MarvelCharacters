//
//  UICollectionViewExtensionTests.swift
//  MarvelCharactersTests
//
//  Created by Cícero Duarte da Silva on 10/07/20.
//  Copyright © 2020 ciceroduarte. All rights reserved.
//

import XCTest
@testable import MarvelCharacters

class UICollectionViewExtensionTests: XCTestCase {

    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    func testDequeueReusableCellShouldReturnRegisteredType() {
        collectionView.register(CharacterCell.self)

        assertCollectionViewCell()
    }

    func testDequeueReusableCellShouldReturnExpectedType() {
        collectionView.register(SerieCell.self, forCellWithReuseIdentifier: "CharacterCell")

        assertCollectionViewCell()
    }

    private func assertCollectionViewCell() {
        let cell = collectionView.dequeueReusableCell(forIndexPath: IndexPath(row: 0, section: 0)) as CharacterCell
        XCTAssertNotNil(cell)
    }
}
