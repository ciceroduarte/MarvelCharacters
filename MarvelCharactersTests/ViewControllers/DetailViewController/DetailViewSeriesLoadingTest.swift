//
//  DetailViewSeriesLoadingTest.swift
//  MarvelCharacters
//
//  Created by Cicero on 07/03/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import XCTest
import KIF
@testable import MarvelCharacters

class DetailViewSeriesLoadingTest: KIFTestCase {
    
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
        let character = DecodableHelper.decode(Character.self, dictionary: representation)
        let detailViewModel = DetailViewModel(withCharacter: character!)
        let mockSession = MockURLSession()
        
        let expectedData = ("{\"data\": { \"offset\": 0, \"limit\": 20, \"total\": 30920," +
            "\"count\": 1, \"results\": [{\"title\": \"cicero\"," +
            "\"thumbnail\":{ \"path\": \"http://www.google.com.br\", \"extension\": \"png\"} }]}}"
            ).data(using: String.Encoding.utf8)
        
        detailViewModel.comicsService.session = mockSession
        
        mockSession.nextData = expectedData
        
        detailViewModel.seriesService.session = mockSession
        
        let detailViewController = DetailViewController(withViewModel: detailViewModel)
        let navigationController = UINavigationController(rootViewController: detailViewController)
        appDelegate?.window?.rootViewController = navigationController
    }
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCharacterDetail() {
        
        tester().tapView(withAccessibilityLabel: LocalizedStrings.series)
        
        guard let collectionView = tester()
            .waitForView(withAccessibilityLabel: "collectionView") as? UICollectionView else {
                XCTFail("CollectionView not found")
                return
        }
        
        XCTAssertNotNil(collectionView)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tester().tapItem(at: indexPath, in: collectionView)
    }
}
