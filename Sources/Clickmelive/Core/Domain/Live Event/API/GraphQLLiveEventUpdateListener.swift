//
//  GraphQLLiveEventUpdateListener.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import Apollo
import ClickmeliveSaasAPI

final class GraphQLLiveEventUpdateListener: GraphQLClient, LiveEventUpdateListener {
    private var cancellables: [String: Cancellable] = [:]

    func listen(id: String, completion: @escaping (LiveEventUpdateListener.Result) -> Void) {
        let subscription = subscribe(subscription: OnLiveEventUpdateSubscription(id: id), mapper: OnLiveEventUpdateSubscriptionMapper.map) { result in
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
