//
//  GraphQLVideoLiker.swift
//  Clickmelive
//
//  Created by Can on 6.03.2024.
//

import ClickmeliveSaasAPI

final class GraphQLVideoLiker: GraphQLClient, VideoLiker {
    func like(videoId: String, userId: String, like: Bool, completion: @escaping (VideoLiker.Result) -> Void) {
        performMutation(mutation: LikeVideoMutation(videoId: videoId, userId: userId, like: like), mapper: LikeVideoMutationMapper.map, completion: completion)
    }
}
