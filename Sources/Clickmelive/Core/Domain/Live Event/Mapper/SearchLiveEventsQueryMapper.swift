//
//  SearchLiveEventsMapper.swift
//  ClickmeliveCore
//
//  Created by Can on 3.03.2024.
//

import Foundation
import ClickmeliveSaasAPI

struct SearchLiveEventsQueryMapper {
    static func map(data: SearchLiveEventsQuery.Data?) -> Result<[LiveEvent], Error> {
        guard let data = data else {
            return .failure(GraphQLMapperError.noDataReceived)
        }

        guard let liveEventsData = data.searchLiveEvents?.liveEvents?.compactMap({ $0 }) else {
            return .failure(GraphQLMapperError.dataMissing)
        }

        let liveEvents: [LiveEvent] = liveEventsData.compactMap {
            $0.fragments.liveEventGQL.toLiveEvent
        }
        
        return .success(liveEvents)
    }
}

