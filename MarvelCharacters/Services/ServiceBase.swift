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
    var session: URLSessionProtocol
    private var task: URLSessionDataTaskProtocol?
    
    internal var parameters: String {
        let authentication = (timestamp() + Keys.privateKey + Keys.publicKey).md5()
        return "?" + ServiceParameters.timestamp + "=" + timestamp() + "&"
            + ServiceParameters.apiKey + "=" + Keys.publicKey + "&"
            + ServiceParameters.hash + "=" + authentication
    }
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func getParameters() -> String {
        return parameters
    }
    
    internal func url(withPath path: String) -> URL? {
        return URL(string: Servies.base + path
            + parameters + "&"
            + ServiceParameters.offset + "=" + "\(offset)")
    }
    
    internal func fetch<T: Representable>(listOf representable: T.Type, withURL url: URL?,
                                          completionHandler: @escaping (Result<[T], FetchError>) -> Void) {
        
        guard let url = url else {
            completionHandler(Result.failure(FetchError.invalidURL))
            return
        }
        
        if offset != 0 && offset == total {
            completionHandler(Result.failure(FetchError.limite))
            return
        }
        
        task = session.data(with: url) { (data, response, error) -> Void in
            
            guard error == nil else {
                completionHandler(Result.failure(FetchError.networkFailed))
                return
            }
            
            DispatchQueue.global(qos: .default).async {
                
                guard let response = ServiceResponse(data) else {
                    completionHandler(Result.failure(FetchError.invalidJSON))
                    return
                }

                self.offset = response.offset + response.count
                self.total = response.total
                
                var resultList = [T]()
                response.results.forEach({ result in
                    if let result = T(withRepresentation: result) {
                        resultList.append(result)
                    }
                })
                
                DispatchQueue.main.sync {
                    completionHandler(Result.success(resultList))
                }
            }
        }
        task?.resume()
    }
    
    internal func cancel() {
        task?.cancel()
    }
    
    internal func timestamp() -> String {
        return String(format: "%.0f", NSDate().timeIntervalSince1970)
    }
}
