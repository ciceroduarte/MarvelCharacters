//
//  Comics.swift
//  MarvelCharacters
//
//  Created by Cícero Duarte da Silva on 08/07/20.
//  Copyright © 2020 ciceroduarte. All rights reserved.
//

import Foundation

struct Comics: Decodable {
    let available: Int
    let collectionURI: URL
}
