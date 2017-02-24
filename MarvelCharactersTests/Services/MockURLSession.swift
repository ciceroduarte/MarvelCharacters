//
//  MockURLSession.swift
//  MarvelCharacters
//
//  Created by Cicero on 19/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import XCTest
import Foundation
@testable import MarvelCharacters

class MockURLSession: URLSessionProtocol {
    private (set) var lastURL: URL?
    var nextDataTask = MockURLSessionDataTask()
    var nextResponse: HTTPURLResponse?
    var nextData: Data?
    var nextError: FetchError?
    
    func data(with url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        lastURL = url
        completionHandler(nextData, nextResponse, nextError)
        return nextDataTask
    }
}
