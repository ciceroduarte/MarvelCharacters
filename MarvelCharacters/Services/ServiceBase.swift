//
//  ServiceBase.swift
//  MarvelCharacters
//
//  Created by Cicero on 17/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import Foundation

class ServiceBase {
    lazy var offset = 0
    lazy var total = 0
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    var characters: URL {
        guard let url = URL(string: "\(Servies.base)characters?\(getParams())&offset=\(offset)") else {
            fatalError("Invalid characters url")
        }
        
        return url
    }
    
    internal func search<T: Representable>(for representable: T.Type,
                         withURL url: URL,
                         completionHandler: @escaping (Result<[T], FetchError>) -> Void) {
        
        if offset != 0 && offset == total {
            completionHandler(Result.failure(FetchError.limite))
            return
        }
        
        let task = session.dataTask(with: url) { (data, _, _) -> Void in
            
            guard let theData = data,
                let json = try? JSONSerialization
                    .jsonObject(with: theData, options:JSONSerialization.ReadingOptions(rawValue: 0)),
                let jsonDictionary = json as? NSDictionary,
                let data = jsonDictionary.object(forKey: "data") as? NSDictionary,
                let results = data.object(forKey: "results") as? [[String : Any]],
                let offset = data.object(forKey: "offset") as? Int,
                let count = data.object(forKey: "count") as? Int,
                let total = data.object(forKey: "total") as? Int else {
                    
                    completionHandler(Result.failure(FetchError.invalidJSONData))
                    return
            }
            
            self.offset = offset + count
            self.total = total
            
            var resultList = [T]()
            results.forEach({ result in
                if let r = T(withRepresentation: result) {
                    resultList.append(r)
                }
            })
            
            if Thread.isMainThread {
                print("IS MAIN THREAD!")
            } else {
                print("NOT MAIN THREAD!")
            }
            
            DispatchQueue.main.async {
                completionHandler(Result.success(resultList))
            }
        }
        task.resume()
    }
    
    private func getParams () -> String {
        let authentication = "\(timestamp())\(Keys.privateKey)\(Keys.publicKey)".md5()
        return "\(ServiceParameters.timestamp)=\(timestamp())&\(ServiceParameters.apiKey)=" +
        "\(Keys.apikey)&\(ServiceParameters.hash)=\(authentication)"
    }
    
    private func timestamp() -> String {
        return String(format:"%.0f", NSDate().timeIntervalSince1970)
    }
}
