//
//  ItemsUIComposer.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import Foundation

final class ItemsUIComposer {
    private init() {}
    
    static func makeItemsViewController(items: [Item], itemCellControllerOutput :ItemCellControllerOutput) -> ItemsViewController {
        let controller = ItemsViewController()
        
        let imageLoader = SDWebImageLoader()
        
        controller.display(items.map { item in
            let itemViewModel = ItemViewModel(model: item)
            let cellController = ItemCellController(viewModel: itemViewModel, imageLoader: imageLoader)
            cellController.output = itemCellControllerOutput
            return CollectionCellController(id: UUID(), cellController)
        })
        
        return controller
    }
}

