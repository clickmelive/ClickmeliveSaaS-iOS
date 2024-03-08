//
//  GetVideoByIdQueryMapper.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import ClickmeliveSaasAPI

public struct GetVideoByIdQueryMapper {
    public static func map(data: GetVideoByIdQuery.Data?) -> Result<Video, Error> {
        guard let data = data else {
            return .failure(GraphQLMapperError.noDataReceived)
        }

        let videoData = data.getVideoById

        let tags: [Tag] = videoData.tags?.compactMap {$0}.compactMap {
            $0.fragments.eventTagGQL.toTag
        } ?? []
        
        let items: [Item] = videoData.items?.compactMap { $0 }.compactMap {
            $0.fragments.eventItemGQL.toItem
        } ?? []
        
        let video = Video(id: videoData.id,
                          title: videoData.title,
                          tags: tags,
                          items: items,
                          thumbnailUrl: videoData.thumbnailUrl,
                          videoUrl: videoData.videoUrl,
                          totalViewer: videoData.totalViewer,
                          totalLikeCount: videoData.totalLikeCount)
        
        return .success(video)
    }
}
