//
//  ChatMessageViewModel.swift
//  ClickmeliveCore
//
//  Created by Can on 4.03.2024.
//

import Foundation

final class ChatMessageViewModel {
    private let model: ChatMessage
    
    init(model: ChatMessage) {
        self.model = model
    }
    
    var id: String {
        model.id
    }
    
    var userDisplayName: String {
        model.userDisplayName
    }
    
    var message: String {
        model.message
    }
}
