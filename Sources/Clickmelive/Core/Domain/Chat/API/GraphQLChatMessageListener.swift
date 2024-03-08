//
//  GraphQLChatMessageListener.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import Apollo
import ClickmeliveSaasAPI

final class GraphQLChatMessageListener: GraphQLClient, ChatMessageListener {
    private var cancellables: [String: Cancellable] = [:]

    func listen(eventId: String, completion: @escaping (ChatMessageListener.Result) -> Void) {
        let subscription = subscribe(subscription: OnCreateChatMessageSubscription(eventId: eventId), mapper: OnCreateChatMessageSubscriptionMapper.map) { result in
            completion(result)
        }
        cancellables[eventId] = subscription
    }

    func cancelSubscription(for id: String) {
        cancellables[id]?.cancel()
        cancellables[id] = nil
    }

    func cancelAllSubscriptions() {
        cancellables.forEach { $0.value.cancel() }
        cancellables.removeAll()
    }
}
