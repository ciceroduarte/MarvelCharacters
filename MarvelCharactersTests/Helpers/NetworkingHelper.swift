//
//  NetworkingResponseHelper.swift
//  MarvelCharactersTests
//
//  Created by Cícero Duarte da Silva on 11/07/20.
//  Copyright © 2020 ciceroduarte. All rights reserved.
//

import Foundation

enum Reponse: String {
    case valid = "ValidResponse"
    case invalid = "InvalidReponse"
    case empty = "EmptyResponse"
}

class NetworkingHelper {

    func response(_ response: Reponse) -> Data {
        guard let path = Bundle(for: type(of: self)).url(forResource: response.rawValue, withExtension: "json"),
            let result = try? Data(contentsOf: path) else { return Data() }
        return result
    }
}
