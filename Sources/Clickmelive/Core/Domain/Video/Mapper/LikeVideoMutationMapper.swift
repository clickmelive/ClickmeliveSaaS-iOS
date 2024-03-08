//
//  LikeVideoMutationMapper.swift
//  Clickmelive
//
//  Created by Can on 6.03.2024.
//

import ClickmeliveSaasAPI

public struct LikeVideoMutationMapper {
    public static func map(data: LikeVideoMutation.Data?) -> Result<Video, Error> {
        guard let data = data else {
            return .failure(GraphQLMapperError.noDataReceived)
        }

        guard let videoData = data.likeVideo else {
            return .failure(GraphQLMapperError.dataMissing)
        }
        
        let video = videoData.fragments.videoGQL.toVideo
        
        return .success(video)
    }
}
