//
//  HomeViewTryAgainTest.swift
//  MarvelCharacters
//
//  Created by Cicero on 04/03/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import XCTest
import KIF
@testable import MarvelCharacters

class HomeViewTryAgainTest: KIFTestCase {

    override func beforeEach() {
        stopTestsOnFirstBigFailure = true

        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let homeViewModel = HomeViewModel()
        let mockSession = MockURLSession()

        homeViewModel.charactersService.session = mockSession

        let homeViewController = HomeViewController(withHomeViewModel: homeViewModel)
        let navigationController = UINavigationController(rootViewController: homeViewController)
        appDelegate?.window?.rootViewController = navigationController
    }

    func testTryAgain() {
        tester().tapView(withAccessibilityLabel: LocalizedStrings.tryAgain)
    }
}
