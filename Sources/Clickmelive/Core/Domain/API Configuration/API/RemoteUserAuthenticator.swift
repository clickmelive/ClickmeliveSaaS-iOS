//
//  RemoteUserAuthenticator.swift
//  Clickmelive
//
//  Created by Can on 8.03.2024.
//

final class RemoteUserAuthenticator: RemoteClient<APIConfiguration>, UserAuthenticator {
    func authenticate(apiKey: String, completion: @escaping (UserAuthenticator.Result) -> Void) {
        let endPoint = AuthEndpoints.getApiUrl(apiKey: apiKey)
        let urlRequest = endPoint.urlRequest(baseURL: baseURL)
        return execute(with: urlRequest, mapper: APIConfigurationMapper.map, completion: completion)
    }
}
