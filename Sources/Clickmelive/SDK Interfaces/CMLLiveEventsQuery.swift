//
//  CMLLiveEventsQuery.swift
//  ClickmeliveCore
//
//  Created by Can on 4.03.2024.
//

public class CMLLiveEventsQuery {
    static let defaultPage = 1
    static let defaultLimit = 10
    
    public class Params {
        private var page: Int = CMLLiveEventsQuery.defaultPage
        private var limit: Int = CMLLiveEventsQuery.defaultLimit
        private var replayAvailable: Bool?
        private var title: String?
        private var statuses: [LiveEventStatus]?
        private var tags: [String]?

        public init() {}
        
        @discardableResult
        public func page(_ page: Int) -> Params {
            self.page = page
            return self
        }

        @discardableResult
        public func limit(_ limit: Int) -> Params {
            self.limit = limit
            return self
        }

        @discardableResult
        public func replayAvailable(_ replayAvailable: Bool) -> Params {
            self.replayAvailable = replayAvailable
            return self
        }

        @discardableResult
        public func title(_ title: String?) -> Params {
            self.title = title
            return self
        }

        @discardableResult
        public func statuses(_ statuses: [LiveEventStatus]) -> Params {
            self.statuses = statuses
            return self
        }

        @discardableResult
        public func statuses(_ statuses: LiveEventStatus...) -> Params {
            self.statuses = statuses
            return self
        }

        @discardableResult
        public func tags(_ tags: [String]) -> Params {
            self.tags = tags
            return self
        }

        func getPage() -> Int {
            return page
        }

        func getLimit() -> Int {
            return limit
        }

        func getReplayAvailable() -> Bool? {
            return replayAvailable
        }

        func getTitle() -> String? {
            return title
        }

        func getStatuses() -> [String?]? {
            return statuses?.map { $0.rawValue }
        }

        func getTags() -> [String?]? {
            return tags
        }
    }
}

