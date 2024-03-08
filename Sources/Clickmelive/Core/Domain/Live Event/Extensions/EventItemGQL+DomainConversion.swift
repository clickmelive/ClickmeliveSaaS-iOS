//
//  EventItemGQL+DomainConversion.swift
//  ClickmeliveCore
//
//  Created by Can on 4.03.2024.
//

import Foundation
import ClickmeliveSaasAPI

extension EventItemGQL {
    var toItem: Item {
        return .init(name: name, imageUrl: imageUrl, deeplinkUrl: deeplinkUrl)
    }
}
