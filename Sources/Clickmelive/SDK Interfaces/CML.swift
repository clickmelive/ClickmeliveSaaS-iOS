//
//  CML.swift
//  Clickmelive
//
//  Created by Can on 2.03.2024.
//

import Foundation

public class CML {
    public static let shared = CML()

    static var playerFlow: PlayerFlow?
    private var authManager: AuthManager?
    private var options: CMLOptions?

    private init() {}

    public static func initialize(_ cmlOptions: CMLOptions) {
        shared.options = cmlOptions
        shared.ensureUserIdCreated()
        shared.authenticateUser()
    }

    func getApiKey() -> String {
        guard let options = options else {
            fatalError("CML is not initialized. You must initialize CML before accessing API Key.")
        }
        return options.getApiKey()
    }
    
    func getAPIConfiguration() -> APIConfiguration {
        let userDefaults = CMLUserDefaults()
        guard let apiConfiguration = userDefaults.apiConfiguration else {
            fatalError("APIConfiguration must be initialized CML before accessing the SDK. Please try again")
        }
        return apiConfiguration
    }
    
    private func ensureUserIdCreated() {
        let userDefaults = CMLUserDefaults()
        if userDefaults.userId.isEmpty {
            userDefaults.userId = UUID().uuidString
        }
    }
    
    private func authenticateUser() {
        let client = URLSessionHTTPClient(session: .shared)
        let authenticatedClient = HTTPClientHeaderDecorator(decoratee: client, headers: [CMLConstants.authKey: CMLConstants.authHeaderApiValue])
        let userDefaults = CMLUserDefaults()
        let userAuthenticator = RemoteUserAuthenticator(client: authenticatedClient, baseURL: AppEnvironment.baseURL)
        let cachingUserAuthenticator = UserAuthenticatorCacheDecorator(decoratee: userAuthenticator, userDefaults: userDefaults)
        authManager = AuthManager(userAuthenticator: cachingUserAuthenticator)
        authManager?.authenticate(apiKey: getApiKey())
    }
}

extension CML {
    public static func loadLiveEvents(params: CMLLiveEventsQuery.Params, completion: @escaping (Result<[LiveEvent], Error>) -> Void) {
        let liveEventFinder = GraphQLLiveEventFinder(apolloClient: CMLApolloClient.shared.apollo)
        liveEventFinder.find(params: params, completion: completion)
    }
}

extension CML {
    public static func loadVideos(params: CMLVideosQuery.Params, completion: @escaping (Result<[Video], Error>) -> Void) {
        let videoFinder = GraphQLVideoFinder(apolloClient: CMLApolloClient.shared.apollo)
        videoFinder.find(params: params, completion: completion)
    }
}

extension CML {
    public static func startPlayer(cmlPlayerParams: CMLPlayerParams, cmlPlayerUIOptions: CMLPlayerUIOptions, cmlChatOptions: CMLChatOptions) {
        
        setupPlayerUIOptions(with: cmlPlayerUIOptions)
        
        playerFlow = PlayerFlow(cmlPlayerParams: cmlPlayerParams, cmlChatOptions: cmlChatOptions)
        
        playerFlow?.teardown = { coordinator in
            playerFlow = nil
        }
        
        playerFlow?.start()
    }
    
    private static func setupPlayerUIOptions(with options: CMLPlayerUIOptions) {
        Components.default.likeView = options.getIsLikeVisible() ? LikeView.self: HiddenLikeView.self
        Components.default.totalViewerView = options.getIsViewerCountVisible() ? TotalViewerView.self: HiddenTotalViewerView.self
        Components.default.itemsView = options.getIsProductsVisible() ? ItemsView.self: HiddenItemsView.self
        Components.default.statusView = options.getIsEventTypeVisible() ? StatusView.self: HiddenStatusView.self
        Components.default.titleView = options.getIsTitleVisible() ? TitleView.self: HiddenTitleView.self
    }
}
