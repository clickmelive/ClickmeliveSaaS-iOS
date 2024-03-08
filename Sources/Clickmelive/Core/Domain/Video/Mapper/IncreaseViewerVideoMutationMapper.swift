//
//  IncreaseViewerVideoMutationMapper.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import ClickmeliveSaasAPI

public struct IncreaseViewerVideoMutationMapper {
    public static func map(data: IncreaseViewerVideoMutation.Data?) -> Result<Video, Error> {
        guard let data = data else {
            return .failure(GraphQLMapperError.noDataReceived)
        }

        guard let videoData = data.increaseViewerVideo else {
            return .failure(GraphQLMapperError.dataMissing)
        }

        let video = videoData.fragments.videoGQL.toVideo
        
        return .success(video)
    }
}
