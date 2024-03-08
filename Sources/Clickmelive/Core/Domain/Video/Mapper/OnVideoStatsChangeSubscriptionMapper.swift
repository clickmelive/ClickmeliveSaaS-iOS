//
//  OnVideoStatsChangeSubscriptionMapper.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import ClickmeliveSaasAPI

public struct OnVideoStatsChangeSubscriptionMapper {
    public static func map(data: OnVideoStatsChangeSubscription.Data?) -> Result<Video, Error> {
        guard let data = data else {
            return .failure(GraphQLMapperError.noDataReceived)
        }

        guard let videoData = data.onVideoStatsChange else {
            return .failure(GraphQLMapperError.dataMissing)
        }

        let video = videoData.fragments.videoGQL.toVideo
        
        return .success(video)
    }
}
