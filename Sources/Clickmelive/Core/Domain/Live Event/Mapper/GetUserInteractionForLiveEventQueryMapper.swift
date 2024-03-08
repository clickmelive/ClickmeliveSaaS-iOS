//
//  GetUserInteractionForLiveEventQueryMapper.swift
//  ClickmeliveCore
//
//  Created by Can on 2.03.2024.
//

import ClickmeliveSaasAPI

struct GetUserInteractionForLiveEventQueryMapper {
    static func map(data: GetUserInteractionLiveEventQuery.Data?) -> Result<LiveEventUserInteraction, Error> {
        guard let data = data else {
            return .failure(GraphQLMapperError.noDataReceived)
        }

        guard let userInteractionData = data.getUserInteractionForLiveEvent else {
            return .failure(GraphQLMapperError.dataMissing)
        }

        let liveEventUserInteraction = LiveEventUserInteraction(like: userInteractionData.like ?? false)
        
        return .success(liveEventUserInteraction)
    }
}
