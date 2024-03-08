//
//  NetworkInterceptorProvider.swift
//  Clickmelive
//
//  Created by Can on 2.03.2024.
//

import Apollo
import ApolloAPI

class NetworkInterceptorProvider: DefaultInterceptorProvider {
    override func interceptors<Operation>(for operation: Operation) -> [ApolloInterceptor] where Operation : GraphQLOperation {
        var interceptors = super.interceptors(for: operation)
        interceptors.insert(AuthorizationInterceptor(), at: 0)
        return interceptors
    }
}
