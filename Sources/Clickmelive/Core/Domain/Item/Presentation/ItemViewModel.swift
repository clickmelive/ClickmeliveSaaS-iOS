//
//  ItemViewModel.swift
//  ClickmeliveCore
//
//  Created by Can on 3.03.2024.
//

import Foundation

final class ItemViewModel {
    private let model: Item
    
    init(model: Item) {
        self.model = model
    }
    
    var name: String {
        model.name
    }
    
    var imageURL: URL? {
        model.imageUrl.asURL
    }
    
    var deeplinkUrl: URL? {
        model.deeplinkUrl.asURL
    }
}
