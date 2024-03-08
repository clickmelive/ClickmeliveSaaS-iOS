//
//  GetLiveViewerCountQueryMapper.swift
//  ClickmeliveCore
//
//  Created by Can on 2.03.2024.
//

import Foundation
import ClickmeliveSaasAPI

struct GetLiveViewerCountQueryMapper {
    static func map(data: GetLiveViewerCountQuery.Data?) -> Result<LiveEventViewer, Error> {
        guard let data = data else {
            return .failure(GraphQLMapperError.noDataReceived)
        }
        
        guard let liveViewerCountData = data.getLiveViewerCount else {
            return .failure(GraphQLMapperError.dataMissing)
        }
        
        let liveEventViewerCount = LiveEventViewer(viewerCount: liveViewerCountData.viewerCount ?? 0)
    
        return .success(liveEventViewerCount)
    }
}

