//
//  GetLiveEventByIdQueryMapper.swift
//  ClickmeliveCore
//
//  Created by Can on 2.03.2024.
//

import Foundation
import ClickmeliveSaasAPI

struct GetLiveEventByIdQueryMapper {
    static func map(data: GetLiveEventByIdQuery.Data?) -> Result<LiveEvent, Error> {
        guard let data = data else {
            return .failure(GraphQLMapperError.noDataReceived)
        }

        guard let liveEventData = data.getLiveEventById else {
            return .failure(GraphQLMapperError.dataMissing)
        }
        
        let tags: [Tag] = liveEventData.tags?.compactMap {$0}.compactMap {
            $0.fragments.eventTagGQL.toTag
        } ?? []
        
        let items: [Item] = liveEventData.items?.compactMap { $0 }.compactMap {
            $0.fragments.eventItemGQL.toItem
        } ?? []
        
        let status = LiveEventStatus.getLiveEventStatus(from: liveEventData.status)
        
        let liveEvent = LiveEvent(id: liveEventData.id,
                                  status: status,
                                  title: liveEventData.title,
                                  tags: tags,
                                  items: items,
                                  playbackUrl: liveEventData.playbackUrl,
                                  teaserUrl: liveEventData.teaserUrl,
                                  replayUrl: liveEventData.replayUrl,
                                  thumbnailUrl: liveEventData.thumbnailUrl,
                                  totalViewer: liveEventData.totalViewer,
                                  totalLikeCount: liveEventData.totalLikeCount,
                                  estimatedStartingDate: liveEventData.estimatedStartingDate)
        
        return .success(liveEvent)
    }
}
