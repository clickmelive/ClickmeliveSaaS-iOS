//
//  CMLPlayerUIOptions.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

public class CMLPlayerUIOptions {
    private var isViewerCountVisible: Bool
    private var isLikeVisible: Bool
    private var isProductsVisible: Bool
    private var isTitleVisible: Bool
    private var isEventTypeVisible: Bool
   
    private init(isViewerCountVisible: Bool, isLikeVisible: Bool, isProductsVisible: Bool, isTitleVisible: Bool, isEventTypeVisible: Bool) {
        self.isViewerCountVisible = isViewerCountVisible
        self.isLikeVisible = isLikeVisible
        self.isProductsVisible = isProductsVisible
        self.isTitleVisible = isTitleVisible
        self.isEventTypeVisible = isEventTypeVisible
    }
    
    public class Builder {
        
        private var isViewerCountVisible: Bool = true
        private var isLikeVisible: Bool = true
        private var isProductsVisible: Bool = true
        private var isTitleVisible: Bool = true
        private var isEventTypeVisible: Bool = true
        
        public init() {}
        
        public func isViewerCountVisible(_ visible: Bool) -> Builder {
            self.isViewerCountVisible = visible
            return self
        }
        
        public func isLikeVisible(_ visible: Bool) -> Builder {
            self.isLikeVisible = visible
            return self
        }
        
        public func isProductsVisible(_ visible: Bool) -> Builder {
            self.isProductsVisible = visible
            return self
        }
        
        public func isTitleVisible(_ visible: Bool) -> Builder {
            self.isTitleVisible = visible
            return self
        }
        
        public func isEventTypeVisible(_ visible: Bool) -> Builder {
            self.isEventTypeVisible = visible
            return self
        }
        
        public func build() -> CMLPlayerUIOptions {
            return CMLPlayerUIOptions(isViewerCountVisible: isViewerCountVisible,
                                      isLikeVisible: isLikeVisible,
                                      isProductsVisible: isProductsVisible,
                                      isTitleVisible: isTitleVisible,
                                      isEventTypeVisible: isEventTypeVisible)
        }
    }
    
    func getIsLikeVisible() -> Bool {
        return isLikeVisible
    }
    
    func getIsViewerCountVisible() -> Bool {
        return isViewerCountVisible
    }
    
    func getIsProductsVisible() -> Bool {
        return isProductsVisible
    }
    
    func getIsTitleVisible() -> Bool {
        return isTitleVisible
    }
    
    func getIsEventTypeVisible() -> Bool {
        return isEventTypeVisible
    }
}
