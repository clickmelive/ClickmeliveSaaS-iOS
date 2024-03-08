//
//  GraphQLVideoStateChangeListener.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import Apollo
import ClickmeliveSaasAPI

final class GraphQLVideoStateChangeListener: GraphQLClient, VideoStatsChangeListener {
    private var cancellables: [String: Cancellable] = [:]

    func listen(id: String, completion: @escaping (VideoStatsChangeListener.Result) -> Void) {
        let subscription = subscribe(subscription: OnVideoStatsChangeSubscription(id: id), mapper: OnVideoStatsChangeSubscriptionMapper.map) { result in
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
