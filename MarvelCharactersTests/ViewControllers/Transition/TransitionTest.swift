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

    let transitionControllerSpy = TransitionControllerSpy()
    lazy var navigationDelegate = NavigationDelegate(withTransitionController: transitionControllerSpy)
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

    func testTransitionHomeToDetailErroShouldAnimate() {

        tester().waitForView(withAccessibilityLabel: "collectionView")

        let home = navigationController?.viewControllers.first { $0 is HomeViewController } as? HomeViewController
        home?.lastSelectedIndexPath = nil

        let detailViewModel = DetailViewModel(withCharacter: CharacterMock.instance)
        let detailViewController = DetailViewController(withViewModel: detailViewModel)
        home?.navigationController?.pushViewController(detailViewController, animated: true)

        tester().tapView(withAccessibilityLabel: LocalizedStrings.series)

        XCTAssertTrue(transitionControllerSpy.animateWasCalled)
    }

    func testTransitionDetailToHomeErroShouldAnimate() {
        let collectionView = tester().waitForView(withAccessibilityLabel: "collectionView") as? UICollectionView

        let indexPath = IndexPath(row: 0, section: 0)
        tester().tapItem(at: indexPath, in: collectionView)

        tester().tapView(withAccessibilityLabel: LocalizedStrings.series)

        let home = navigationController?.viewControllers.first { $0 is HomeViewController } as? HomeViewController
        home?.lastSelectedIndexPath = nil

        _ = navigationController?.popViewController(animated: true)

        tester().waitForView(withAccessibilityLabel: "collectionView")

        XCTAssertTrue(transitionControllerSpy.animateWasCalled)
    }

    class TransitionControllerSpy: TransitionController {
        var animateWasCalled = false

        override func animate(_ view: UIView? = nil,
                              toPoint point: CGPoint = .zero,
                              destinationView: UIView,
                              transitionContext: UIViewControllerContextTransitioning,
                              completion: (() -> Void)? = nil) {
            animateWasCalled = true
            super.animate(view,
                    toPoint: point,
                    destinationView: destinationView,
                    transitionContext: transitionContext,
                    completion: completion)
        }
    }
}
