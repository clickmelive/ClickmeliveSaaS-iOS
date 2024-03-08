//
//  CMLApolloClient.swift
//  Clickmelive
//
//  Created by Can on 2.03.2024.
//

import Foundation
import Apollo
import ApolloWebSocket

// MARK: Network implementation
class CMLApolloClient {
    static let shared = CMLApolloClient()

    lazy var apollo: ApolloClient = {
        let client = URLSessionClient()
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        let provider = NetworkInterceptorProvider(client: client, store: store)
        
        let url = URL(string: CMLConstants.networkEndPoint)!
        let transport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: url)
        
        let wsUrl = generateWebSocketURL()
        let webSocket = WebSocket(
            url: wsUrl,
            protocol: .graphql_ws
        )
        let requestBody = AppSyncRequestBodyCreator([CMLConstants.authKey: CMLConstants.authValue])
     
        let webSocketTransport = WebSocketTransport(websocket: webSocket, config: WebSocketTransport.Configuration(requestBodyCreator: requestBody))
        let splitTransport = SplitNetworkTransport(
            uploadingNetworkTransport: transport,
            webSocketNetworkTransport: webSocketTransport
        )

        return ApolloClient(networkTransport: splitTransport, store: store)
    }()

    private func generateWebSocketURL() -> URL {
        let authDict = [
            CMLConstants.authKey: CMLConstants.authValue,
            CMLConstants.hostKey: CMLConstants.hostValue,
        ]

        let headerData: Data = try! JSONSerialization.data(withJSONObject: authDict, options: JSONSerialization.WritingOptions.prettyPrinted)
        let headerBase64 = headerData.base64EncodedString()

        let payloadData = try! JSONSerialization.data(withJSONObject: [:], options: JSONSerialization.WritingOptions.prettyPrinted)
        let payloadBase64 = payloadData.base64EncodedString()

        let url = URL(string: CMLConstants.realtimeEndPoint + "?header=\(headerBase64)&payload=\(payloadBase64)")!

        return url
    }
}

