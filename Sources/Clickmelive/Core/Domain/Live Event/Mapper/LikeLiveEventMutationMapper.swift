//
//  LikeLiveEventMutationMapper.swift
//  ClickmeliveCore
//
//  Created by Can on 2.03.2024.
//

import Foundation
import ClickmeliveSaasAPI

struct LikeLiveEventMutationMapper {
    static func map(data: LikeLiveEventMutation.Data?) -> Result<LiveEvent, Error> {
        guard let data = data else {
            return .failure(GraphQLMapperError.noDataReceived)
        }
        
        guard let liveEventData = data.likeLiveEvent?.fragments.liveEventGQL else {
            return .failure(GraphQLMapperError.dataMissing)
        }
        
        return .success(liveEventData.toLiveEvent)
    }
}

