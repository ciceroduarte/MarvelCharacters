//
//  URLSessionDataTaskProtocol.swift
//  MarvelCharacters
//
//  Created by Cicero on 19/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
    func cancel()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol { }
