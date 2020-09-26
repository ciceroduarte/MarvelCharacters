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

    func testOnEndReachedShouldCallLoadCharacters() {
        let expec = expectation(description: "Should call load characters two times")
        let sut = HomeViewModelSpy(withCharactersService: StubCharactersService())
        let homeViewController = HomeViewController(withHomeViewModel: sut)

        homeViewController.loadViewIfNeeded()
        let lastIndex = sut.numberOfCharacters() - 1
        homeViewController.collectionView(homeViewController.contentView.collectionView,
                                          prefetchItemsAt: [IndexPath(row: 0, section: lastIndex)])

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(sut.loadCharactersCount, 2)
            expec.fulfill()
        }

        wait(for: [expec], timeout: 1.0)
    }

    func testOnEndNotReachedShouldNotCallLoadCharacters() {
        let expec = expectation(description: "Should not call load characters two times")
        let sut = HomeViewModelSpy(withCharactersService: StubCharactersService(isEmpty: true))
        let homeViewController = HomeViewController(withHomeViewModel: sut)

        homeViewController.loadViewIfNeeded()
        homeViewController.collectionView(homeViewController.contentView.collectionView,
                                          prefetchItemsAt: [IndexPath(row: 0, section: 1)])

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(sut.loadCharactersCount, 1)
            expec.fulfill()
        }

        wait(for: [expec], timeout: 1.0)
    }

    private class HomeViewModelSpy: HomeViewModel {
        var loadCharactersCount = 0
        override func loadCharacters() {
            loadCharactersCount += 1
            super.loadCharacters()
        }
    }

    private class StubCharactersService: CharactersService {
        private let isEmpty: Bool

        init(isEmpty: Bool = false) {
            self.isEmpty = isEmpty
        }

        override func fetch<T>(listOf representable: T.Type,
                               withURL url: URL?,
                               completionHandler: @escaping (Result<[T], FetchError>) -> Void) where T: Decodable {
            guard let character = CharacterMock.instance as? T else {
                completionHandler(Result.failure(.networkFailed))
                return
            }
            let resul: [T] = isEmpty ? [] : [character]
            completionHandler(Result.success(resul))
        }
    }
}
