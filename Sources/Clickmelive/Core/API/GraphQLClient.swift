//
//  GraphQLClient.swift
//  ClickmeliveCore
//
//  Created by Can on 2.03.2024.
//

import Foundation
import Apollo
import ApolloAPI

class GraphQLClient {
    private let apolloClient: ApolloClient
    
    init(apolloClient: ApolloClient) {
        self.apolloClient = apolloClient
    }
    
    func perform<T: GraphQLQuery, Resource>(
                query: T,
                mapper: @escaping (T.Data?) throws -> Result<Resource, Error>,
                completion: @escaping (Result<Resource, Error>) -> Void
    ) {
        apolloClient.fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { result in
            switch result {
            case .success(let graphQLResult):
                do {
                    let mappingResult = try mapper(graphQLResult.data)
                    completion(mappingResult)
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func subscribe<T: GraphQLSubscription, Resource>(
                subscription: T,
                mapper: @escaping (T.Data?) throws -> Result<Resource, Error>,
                completion: @escaping (Result<Resource, Error>) -> Void
    ) -> Cancellable {
        return apolloClient.subscribe(subscription: subscription) { result in
            switch result {
            case .success(let graphQLResult):
                do {
                    let mappingResult = try mapper(graphQLResult.data)
                    completion(mappingResult)
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func performMutation<T: GraphQLMutation, Resource>(
                mutation: T,
                mapper: @escaping (T.Data?) throws -> Result<Resource, Error>,
                completion: @escaping (Result<Resource, Error>) -> Void
    ) {
        apolloClient.perform(mutation: mutation, publishResultToStore: false) { result in
            switch result {
            case .success(let graphQLResult):
                do {
                    let mappingResult = try mapper(graphQLResult.data)
                    completion(mappingResult)
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

