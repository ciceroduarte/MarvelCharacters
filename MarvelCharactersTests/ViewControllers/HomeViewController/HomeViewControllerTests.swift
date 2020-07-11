//
//  HomeViewControllerTests.swift
//  MarvelCharactersTests
//
//  Created by Cícero Duarte da Silva on 10/07/20.
//  Copyright © 2020 ciceroduarte. All rights reserved.
//

import XCTest
@testable import MarvelCharacters

class HomeViewControllerTests: KIFTestCase {

    let mockSession = MockURLSession()

    override func beforeEach() {
        let homeViewModel = HomeViewModel()
        homeViewModel.charactersService.session = mockSession

        let homeViewController = HomeViewController(withHomeViewModel: homeViewModel)
        let navigationController = UINavigationController(rootViewController: homeViewController)

        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.window?.rootViewController = navigationController
    }

    func testInitWithCoderShouldBeNil() {
        XCTAssertNil(HomeViewController(coder: NSCoder()))
    }

    func testCharacterDetail() {
        mockSession.nextData = NetworkingHelper().response(of: .characterList, status: .valid)

        let collectionView = tester().waitForView(withAccessibilityLabel: "collectionView") as? UICollectionView
        let cell = tester().waitForCell(at: IndexPath(row: 0, section: 0), in: collectionView)

        XCTAssertNotNil(cell)
    }

    func testTryAgain() {
        mockSession.nextData = NetworkingHelper().response(of: .characterList, status: .invalid)

        tester().tapView(withAccessibilityLabel: LocalizedStrings.tryAgain)
    }

    func testEmptyData() {
        mockSession.nextData = NetworkingHelper().response(of: .characterList, status: .empty)

        let emptyData = tester().waitForView(withAccessibilityLabel: LocalizedStrings.emptyData.string)

        XCTAssertNotNil(emptyData)
    }
}
