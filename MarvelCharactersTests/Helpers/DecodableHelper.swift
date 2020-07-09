//
//  DecodableHelper.swift
//  MarvelCharactersTests
//
//  Created by Cícero Duarte da Silva on 08/07/20.
//  Copyright © 2020 ciceroduarte. All rights reserved.
//

import Foundation

struct DecodableHelper {

    static func decode<T: Decodable>(_ decodable: T.Type, dictionary: [String: Any]) -> T? {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted) else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: jsonData)
    }
}
