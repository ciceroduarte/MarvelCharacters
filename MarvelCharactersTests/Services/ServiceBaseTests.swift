//
//  ServiceBaseTests.swift
//  MarvelCharacters
//
//  Created by Cicero on 19/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import XCTest
import Foundation
@testable import MarvelCharacters

class ServiceBaseTests: XCTestCase {
    var sut: ServiceBase!
    var session = MockURLSession()
    let url = URL(string: "http://www.github.com")!
    var error: FetchError?
    
    override func setUp() {
        super.setUp()
        sut = ServiceBase(session: session)
        error = nil
    }
    
    func testRequestURL() {
        sut.fetch(listOf: Character.self, withURL: url) { (_) in }
        
        XCTAssert(session.lastURL == url)
    }
    
    func testResumeWasCalled() {
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask
        
        sut.fetch(listOf: Character.self, withURL: url) { (_) in }
        
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func testResponseDataReturnsError() {
        sut.fetch(listOf: Character.self, withURL: url) { (response) in
            switch response {
            case .success(let characters):
                XCTAssertNil(characters)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    func testResponseLimiteFetch() {
        sut.offset = 10
        sut.total = 10
        sut.fetch(listOf: Character.self, withURL: url) { (response) in
            switch response {
            case .success(let characters):
                XCTAssertNil(characters)
            case .failure(let error):
                XCTAssertEqual(error, FetchError.limite)
            }
        }
    }

    func testInvalidResponse() {
        
        let exp = expectation(description: "Invalid response not nil")
        
        let expectedData = ("{\"data\":{ \"offset\": 0, \"limit\": 20, \"total\": 30920," +
            "\"count\": 20,\"results\": [{\"invalid_name\": \"cicero\", \"description\": \"description\"," +
            "\"thumbnail\":{ \"path\": \"http://www.google.com.br\", \"extension\": \"png\" } }]}}"
            ).data(using: String.Encoding.utf8)
        session.nextData = expectedData
        sut.fetch(listOf: Character.self, withURL: url) { (response) in
            switch response {
            case .success(let characters):
                XCTAssertEqual(characters.count, 0)
            case .failure(let error):
                XCTAssertNil(error)
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testValidResponse() {
        
        let exp = expectation(description: "Invalid response")
        
        let expectedData = ("{\"data\": { \"offset\": 0, \"limit\": 20, \"total\": 30920," +
        "\"count\": 20, \"results\": [{\"name\": \"cicero\", \"description\": \"description\"," +
            "\"comics\": { \"collectionURI\": \"http://www.google.com.br\" }," +
            "\"series\": { \"collectionURI\": \"http://www.google.com.br\" }," +
        "\"thumbnail\":{ \"path\": \"http://www.google.com.br\", \"extension\": \"png\"} }]}}"
            ).data(using: String.Encoding.utf8)
        session.nextData = expectedData
        sut.fetch(listOf: Character.self, withURL: url) { (response) in
            switch response {
            case .success(let characters):
                XCTAssertNotNil(characters)
            case .failure(let error):
                XCTAssertNil(error)
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testInvalidURL() {
        
        sut.fetch(listOf: Character.self, withURL: nil) { (response) in
            switch response {
            case .failure(let error):
                XCTAssertEqual(error, FetchError.invalidURL)
            default: break
            }
        }
    }

    func testWithError() {
        session.nextError = .networkFailed
        sut.fetch(listOf: Character.self, withURL: url) { (response) in
            switch response {
            case .failure(let error):
                XCTAssertEqual(error, .networkFailed)
            default: break
            }
        }
    }
}
