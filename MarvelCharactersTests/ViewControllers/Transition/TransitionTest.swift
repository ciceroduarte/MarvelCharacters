//
//  TransitionTest.swift
//  MarvelCharacters
//
//  Created by Cicero on 07/03/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import XCTest
import KIF
@testable import MarvelCharacters

class TransitionTest: KIFTestCase {

    let navigationDelegate = NavigationDelegate()
    var navigationController: UINavigationController?

    override func beforeEach() {
        let mockSession = MockURLSession()
        mockSession.nextData = NetworkingHelper().response(of: .characterList, status: .valid)

        let homeViewModel = HomeViewModel()
        homeViewModel.charactersService.session = mockSession

        let homeViewController = HomeViewController(withHomeViewModel: homeViewModel)
        navigationController = UINavigationController(rootViewController: homeViewController)
        navigationController?.delegate = navigationDelegate

        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.window?.rootViewController = navigationController
    }

    func testTransition() {
        let collectionView = tester().waitForView(withAccessibilityLabel: "collectionView") as? UICollectionView

        let indexPath = IndexPath(row: 0, section: 0)
        tester().tapItem(at: indexPath, in: collectionView)

        _ = navigationController?.popViewController(animated: true)

        tester().tapItem(at: indexPath, in: collectionView)
    }
}
