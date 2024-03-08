//
//  GraphQLVideoViewerIncreaser.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import ClickmeliveSaasAPI

final class GraphQLVideoViewerIncreaser: GraphQLClient, VideoViewerIncreaser {
    func increase(id: String, userId: String, completion: @escaping (VideoDetailLoader.Result) -> Void) {
        performMutation(mutation: IncreaseViewerVideoMutation(id: id, userId: userId), mapper: IncreaseViewerVideoMutationMapper.map, completion: completion)
    }
}
