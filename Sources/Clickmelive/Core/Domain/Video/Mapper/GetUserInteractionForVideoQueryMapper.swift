//
//  GetUserInteractionForVideoQueryMapper.swift
//  Clickmelive
//
//  Created by Can on 6.03.2024.
//

import ClickmeliveSaasAPI

struct GetUserInteractionForVideoQueryMapper {
    static func map(data: GetUserInteractionForVideoQuery.Data?) -> Result<VideoUserInteraction, Error> {
        guard let data = data else {
            return .failure(GraphQLMapperError.noDataReceived)
        }

        guard let userInteractionData = data.getUserInteractionForVideo else {
            return .failure(GraphQLMapperError.dataMissing)
        }

        let videoUserInteraction = VideoUserInteraction(like: userInteractionData.like ?? false)
        
        return .success(videoUserInteraction)
    }
}
