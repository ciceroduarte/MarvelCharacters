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
        stopTestsOnFirstBigFailure = true
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let homeViewModel = HomeViewModel()
        let mockSession = MockURLSession()
        
        let expectedData = ("{\"data\": { \"offset\": 0, \"limit\": 20, \"total\": 30920," +
            "\"count\": 20, \"results\": [{\"name\": \"cicero\", \"description\": \"description\"," +
            "\"comics\": { \"collectionURI\": \"http://www.google.com.br\" }," +
            "\"series\": { \"collectionURI\": \"http://www.google.com.br\" }," +
            "\"thumbnail\":{ \"path\": \"http://www.google.com.br\", \"extension\": \"png\"} }]}}"
            ).data(using: String.Encoding.utf8)
        mockSession.nextData = expectedData
        
        homeViewModel.charactersService.session = mockSession
        
        let homeViewController = HomeViewController(withHomeViewModel: homeViewModel)
        navigationController = UINavigationController(rootViewController: homeViewController)
        navigationController?.delegate = navigationDelegate
        appDelegate?.window?.rootViewController = navigationController
    }
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //TODO: Add transitionMock to verify transition call
    func testTransition() {
        guard let collectionView = tester()
            .waitForView(withAccessibilityLabel: "collectionView") as? UICollectionView else {
                XCTFail("CollectionView not found")
                return
        }
        
        XCTAssertNotNil(collectionView)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tester().tapItem(at: indexPath, in: collectionView)

        _ = navigationController?.popViewController(animated: true)

        tester().tapItem(at: indexPath, in: collectionView)
    }
}
