//
//  GraphQLLiveEventDetailLoader.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import ClickmeliveSaasAPI

final class GraphQLLiveEventDetailLoader: GraphQLClient, LiveEventDetailLoader {
    func load(id: String, completion: @escaping (LiveEventDetailLoader.Result) -> Void) {
        perform(query: GetLiveEventByIdQuery(id: id), mapper: GetLiveEventByIdQueryMapper.map, completion: completion)
    }
}
