//
//  GraphQLVideoFinder.swift
//  ClickmeliveCore
//
//  Created by Can on 4.03.2024.
//

import ClickmeliveSaasAPI

final class GraphQLVideoFinder: GraphQLClient, VideoFinder {
    func find(params: CMLVideosQuery.Params, completion: @escaping (VideoFinder.Result) -> Void) {
        let input: VideoSearchInput = .init(
            title: GraphQLNullable(optionalValue: params.getTitle()),
            tags: GraphQLNullable(optionalValue: params.getTags()),
            limit: GraphQLNullable(optionalValue: params.getLimit()),
            page: GraphQLNullable(optionalValue: params.getPage()))
        
        let nullableInput = GraphQLNullable(optionalValue: input)
        perform(query: SearchVideosQuery(input: nullableInput), mapper: SearchVideosQueryMapper.map, completion: completion)
    }
}
