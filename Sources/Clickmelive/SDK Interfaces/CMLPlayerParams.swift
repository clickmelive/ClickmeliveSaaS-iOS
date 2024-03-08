//
//  CMLPlayerParams.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

public class CMLPlayerParams {
    private var playerType: PlayerType

    private init(playerType: PlayerType) {
        self.playerType = playerType
    }
    
    public class Builder {
        
        private var playerType: PlayerType?
        
        public init() {}
        
        public func setType(_ playerType: PlayerType) -> Builder {
            self.playerType = playerType
            return self
        }
        
        public func build() -> CMLPlayerParams {
            guard let playerType = self.playerType else {
                fatalError("Error: player type is required.")
            }
            return CMLPlayerParams(playerType: playerType)
        }
    }
    
    public func getType() -> PlayerType {
        return playerType
    }
}
