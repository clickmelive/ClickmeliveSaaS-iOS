//
//  IncreaseViewerLiveEventMutationMapper.swift
//  ClickmeliveCore
//
//  Created by Can on 2.03.2024.
//

import Foundation
import ClickmeliveSaasAPI

struct IncreaseViewerLiveEventMutationMapper {
    static func map(data: IncreaseViewerLiveEventMutation.Data?) -> Result<LiveEvent, Error> {
        guard let data = data else {
            return .failure(GraphQLMapperError.noDataReceived)
        }
        
        guard let liveEventData = data.increaseViewerLiveEvent?.fragments.liveEventGQL else {
            return .failure(GraphQLMapperError.dataMissing)
        }
        
        return .success(liveEventData.toLiveEvent)
    }
}
