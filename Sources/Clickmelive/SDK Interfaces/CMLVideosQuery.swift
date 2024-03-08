//
//  CMLVideosQuery.swift
//  ClickmeliveCore
//
//  Created by Can on 4.03.2024.
//

public class CMLVideosQuery {
    static let defaultPage = 1
    static let defaultLimit = 10
    
    public class Params {
        private var page: Int = CMLLiveEventsQuery.defaultPage
        private var limit: Int = CMLLiveEventsQuery.defaultLimit
        private var title: String?
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
        public func title(_ title: String?) -> Params {
            self.title = title
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

        func getTitle() -> String? {
            return title
        }

        func getTags() -> [String?]? {
            return tags
        }
    }
}


