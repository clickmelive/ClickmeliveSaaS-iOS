//
//  SearchVideosQueryMapper.swift
//  ClickmeliveCore
//
//  Created by Can on 4.03.2024.
//

import Foundation
import ClickmeliveSaasAPI

struct SearchVideosQueryMapper {
    static func map(data: SearchVideosQuery.Data?) -> Result<[Video], Error> {
        guard let data = data else {
            return .failure(GraphQLMapperError.noDataReceived)
        }

        guard let videosData = data.searchVideos?.videos?.compactMap({ $0 }) else {
            return .failure(GraphQLMapperError.dataMissing)
        }

        let videos: [Video] = videosData.compactMap {
            $0.fragments.videoGQL.toVideo
        }
        
        return .success(videos)
    }
}
