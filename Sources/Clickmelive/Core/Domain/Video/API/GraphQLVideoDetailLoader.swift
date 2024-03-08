//
//  GraphQLVideoDetailLoader.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import ClickmeliveSaasAPI

final class GraphQLVideoDetailLoader: GraphQLClient, VideoDetailLoader {
    func load(id: String, completion: @escaping (VideoDetailLoader.Result) -> Void) {
        perform(query: GetVideoByIdQuery(id: id), mapper: GetVideoByIdQueryMapper.map, completion: completion)
    }
}
