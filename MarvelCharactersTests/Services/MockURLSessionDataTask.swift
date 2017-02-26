//
//  MockURLSessionDataTask.swift
//  MarvelCharacters
//
//  Created by Cicero on 19/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import Foundation
@testable import MarvelCharacters

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false
    
    func resume() {
        resumeWasCalled = true
    }
    
    func cancel() {
        
    }
}
