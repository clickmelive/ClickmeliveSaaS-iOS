//
//  GraphQLVideoUserInteractionLoader.swift
//  Clickmelive
//
//  Created by Can on 6.03.2024.
//

import ClickmeliveSaasAPI

final class GraphQLVideoUserInteractionLoader: GraphQLClient, VideoUserInteractionLoader {
    func load(videoId: String, userId: String, completion: @escaping (VideoUserInteractionLoader.Result) -> Void) {
        perform(query: GetUserInteractionForVideoQuery(id: videoId, userId: userId), mapper: GetUserInteractionForVideoQueryMapper.map, completion: completion)
    }
}
