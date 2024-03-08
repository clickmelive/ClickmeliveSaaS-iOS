//
//  LiveEventStatus.swift
//  ClickmeliveCore
//
//  Created by Can on 2.03.2024.
//

public enum LiveEventStatus: String {
    case None
    case Created
    case Teaser
    case ReadyToStream
    case Streaming
    case StreamEnded
    case Cancelled
    
    static func getLiveEventStatus(from: Int?) -> LiveEventStatus {
        switch from {
        case 0:
            return .Created
        case 1:
            return .Teaser
        case 2:
            return .ReadyToStream
        case 3:
            return .Streaming
        case 4:
            return .StreamEnded
        case 5:
            return .Cancelled
        default:
            return .None
        }
    }
}
