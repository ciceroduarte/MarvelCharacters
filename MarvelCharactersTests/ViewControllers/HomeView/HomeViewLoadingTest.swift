//
//  MarvelCharactersTests.swift
//  MarvelCharactersTests
//
//  Created by Cicero on 15/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import XCTest
import KIF
@testable import MarvelCharacters

class HomeViewLoadingTest: KIFTestCase {

    override func beforeEach() {
        stopTestsOnFirstBigFailure = true

        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let homeViewModel = HomeViewModel()
        let mockSession = MockURLSession()

        let expectedData = ("""
            { "data": { "offset": 0, "limit": 20, "total": 30920,
            "count": 20, "results": [{"name": "cicero", "description": "description",
            "comics": { "collectionURI": "http://www.google.com.br\", "available": 1 },
            "series": { "collectionURI": "http://www.google.com.br\", "available": 1 },
            "thumbnail":{ "path": "http://www.google.com.br", "extension": "png"} }]}}
        """).data(using: String.Encoding.utf8)
        mockSession.nextData = expectedData

        homeViewModel.charactersService.session = mockSession

        let homeViewController = HomeViewController(withHomeViewModel: homeViewModel)
        let navigationController = UINavigationController(rootViewController: homeViewController)
        appDelegate?.window?.rootViewController = navigationController
    }

    func testCharacterDetail() {
        let collectionView = tester().waitForView(withAccessibilityLabel: "collectionView") as? UICollectionView

        XCTAssertNotNil(collectionView)

        let indexPath = IndexPath(row: 0, section: 0)
        let cell = tester().waitForCell(at: indexPath, in: collectionView)
        XCTAssertNotNil(cell)
    }
}
