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
    static let privateKey: String = "!!!PRIVATE KEY!!!"
    static let publicKey: String = "!!!PUBLIC KEY!!!"
    static let apikey: String = "!!!API KEY!!!"
}

struct Servies {
    static let base: String = "https://gateway.marvel.com/v1/public/"
}

struct ServiceParameters {
    static let apiKey: String = "apikey"
    static let hash: String = "hash"
    static let timestamp: String = "ts"
    static let offset: String = "offset"
}
