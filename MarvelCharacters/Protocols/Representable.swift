//
//  Representable.swift
//  MarvelCharacters
//
//  Created by Cicero on 16/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import Foundation

protocol Representable {
    init?(withRepresentation: Dictionary<String, Any>?)
}
