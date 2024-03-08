//
//  RemoteClient.swift
//  Clickmelive
//
//  Created by Can on 8.03.2024.
//

import Foundation

class RemoteClient<Resource> {
    let client: HTTPClient
    let baseURL: URL
    
    typealias Mapper = (Data, HTTPURLResponse) throws -> Resource
    typealias CompletionHandler = (Result<Resource, Error>) -> Void
    
    init(client: HTTPClient,
         baseURL: URL) {
        self.client = client
        self.baseURL = baseURL
    }
    
    func execute(with urlRequest: URLRequest, mapper: @escaping Mapper, completion: @escaping CompletionHandler) {
        client.execute(with: urlRequest) { response in
            switch response {
            case .success(let (data, httpResponse)):
                do {
                    let resource = try mapper(data, httpResponse)
                    completion(.success(resource))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
