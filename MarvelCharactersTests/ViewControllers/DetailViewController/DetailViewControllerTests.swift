//
//  DetailViewControllerTests.swift
//  MarvelCharactersTests
//
//  Created by Cícero Duarte da Silva on 11/07/20.
//  Copyright © 2020 ciceroduarte. All rights reserved.
//

import XCTest
import KIF
@testable import MarvelCharacters

class DetailViewControllerTest: KIFTestCase {

    let mockSession = MockURLSession()

    override func beforeEach() {
        stopTestsOnFirstBigFailure = true
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
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
        guard let character = DecodableHelper.decode(Character.self, dictionary: representation) else {
            XCTFail("Can`t create character")
            return
        }
        let detailViewModel = DetailViewModel(withCharacter: character)

        mockSession.nextData = NetworkingHelper().response(of: .characterDetail, status: .valid)

        detailViewModel.comicsService.session = mockSession
        detailViewModel.seriesService.session = mockSession

        let detailViewController = DetailViewController(withViewModel: detailViewModel)
        let navigationController = UINavigationController(rootViewController: detailViewController)
        appDelegate?.window?.rootViewController = navigationController
    }

    func testInitWithCoderShouldBeNil() {
        XCTAssertNil(DetailViewController(coder: NSCoder()))
    }

    func testComicsCharacterDetail() {
        tester().tapView(withAccessibilityLabel: LocalizedStrings.series)
        tester().tapView(withAccessibilityLabel: LocalizedStrings.comics)

        tapListItem()
    }

    func testSeriesCharacterDetail() {
        tester().tapView(withAccessibilityLabel: LocalizedStrings.series)
        tapListItem()
    }

    func testComicsTryAgain() {
        mockSession.nextData = NetworkingHelper().response(of: .characterDetail, status: .invalid)

        tester().waitForView(withAccessibilityLabel: LocalizedStrings.tryAgain)

        mockSession.nextData = NetworkingHelper().response(of: .characterDetail, status: .valid)

        tester().tapView(withAccessibilityLabel: LocalizedStrings.tryAgain)

        tapListItem()
    }

    func testSeriesTryAgain() {
        mockSession.nextData = NetworkingHelper().response(of: .characterDetail, status: .invalid)

        tester().tapView(withAccessibilityLabel: LocalizedStrings.series)
        tester().waitForView(withAccessibilityLabel: LocalizedStrings.tryAgain)

        mockSession.nextData = NetworkingHelper().response(of: .characterDetail, status: .valid)

        tester().tapView(withAccessibilityLabel: LocalizedStrings.tryAgain)

        tapListItem()
    }

    func testSeriesShouldNotCallServiceTwice() {
        tester().tapView(withAccessibilityLabel: LocalizedStrings.series)
        tester().tapView(withAccessibilityLabel: LocalizedStrings.comics)

        mockSession.nextData = NetworkingHelper().response(of: .characterDetail, status: .invalid)

        tester().tapView(withAccessibilityLabel: LocalizedStrings.series)
        tapListItem()
    }

    private func tapListItem() {
        let collectionView = tester().waitForView(withAccessibilityLabel: "collectionView") as? UICollectionView

        XCTAssertNotNil(collectionView)

        let indexPath = IndexPath(row: 0, section: 0)
        tester().tapItem(at: indexPath, in: collectionView)
    }
}
