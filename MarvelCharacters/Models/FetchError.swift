//
//  FetchError.swift
//  MarvelCharacters
//
//  Created by Cicero on 17/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import Foundation

enum FetchError: Error {
    case invalidJSON
    case invalidURL
    case networkFailed
    case limite
}
