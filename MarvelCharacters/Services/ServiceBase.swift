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
    
    func fetch<T: Representable>(listOf representable: T.Type,
                         withURL url: URL,
                         completionHandler: @escaping (Result<[T], FetchError>) -> Void) {
        
        if offset != 0 && offset == total {
            completionHandler(Result.failure(FetchError.limite))
            return
        }
        
        let task = session.dataTask(with: url) { (data, _, _) -> Void in
            
            DispatchQueue.global(qos: .background).async {
                
                guard let response = ServiceResponse(data) else {
                    completionHandler(Result.failure(FetchError.invalidJSON))
                    return
                }

                self.offset = response.offset + response.count
                self.total = response.total
                
                var resultList = [T]()
                response.results.forEach({ result in
                    if let r = T(withRepresentation: result) {
                        resultList.append(r)
                    }
                })
                
                DispatchQueue.main.sync {
                    completionHandler(Result.success(resultList))
                }
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
