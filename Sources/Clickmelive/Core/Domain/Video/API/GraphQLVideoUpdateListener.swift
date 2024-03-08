//
//  GraphQLVideoUpdateListener.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import Apollo
import ClickmeliveSaasAPI

final class GraphQLVideoUpdateListener: GraphQLClient, VideoUpdateListener {
    private var cancellables: [String: Cancellable] = [:]

    func listen(id: String, completion: @escaping (VideoUpdateListener.Result) -> Void) {
        let subscription = subscribe(subscription: OnVideoUpdateSubscription(id: id), mapper: OnVideoUpdateSubscriptionMapper.map) { result in
            completion(result)
        }
        cancellables[id] = subscription
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
