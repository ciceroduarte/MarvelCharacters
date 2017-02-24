//
//  Constants.swift
//  MarvelCharacters
//
//  Created by Cicero on 17/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import Foundation

struct Layout {
    static let margin = 8
}

struct Keys {
    
    static let privateKey: String = "2dc5a57020809d6acff539ab7c46d2394dfc3277"
    static let publicKey: String = "bb2a90b54d60d4eae7c9b5b33d803a4a"
    static let apikey: String = "bb2a90b54d60d4eae7c9b5b33d803a4a"
}

struct Servies {
    static let base: String = "http://gateway.marvel.com:80/v1/public/"
}

struct ServiceParameters {
    static let apiKey: String = "apikey"
    static let hash: String = "hash"
    static let timestamp: String = "ts"
}
