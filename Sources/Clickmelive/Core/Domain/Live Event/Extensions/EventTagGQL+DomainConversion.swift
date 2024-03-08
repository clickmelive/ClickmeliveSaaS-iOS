//
//  EventTagGQL+DomainConversion.swift
//  ClickmeliveCore
//
//  Created by Can on 4.03.2024.
//

import ClickmeliveSaasAPI

extension EventTagGQL {
    var toTag: Tag {
        .init(title: title)
    }
}
