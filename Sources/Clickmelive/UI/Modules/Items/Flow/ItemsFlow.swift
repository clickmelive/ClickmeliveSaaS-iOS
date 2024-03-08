//
//  ItemsFlow.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import UIKit

class ItemsFlow: ChildCoordinator {
    
    deinit {
        print("deinit ItemsFlow")
    }
    
    var teardown: ((ItemsFlow) -> Void)?
    
    private weak var controller: PlayerViewController?
    private let items: [Item]
    
    init(controller: PlayerViewController?,
         items: [Item]) {
        self.controller = controller
        self.items = items
    }
    
    func start() {
        let itemsUIComposer = ItemsUIComposer.makeItemsViewController(
            items: items,
            itemCellControllerOutput: WeakRef(self)
        )
        
        itemsUIComposer.onDeinit { [weak self] in
            self?.stop()
        }
        
        itemsUIComposer.modalPresentationStyle = .formSheet
        itemsUIComposer.modalTransitionStyle = .coverVertical
        
        controller?.present(itemsUIComposer, animated: true)
    }
}

extension ItemsFlow: ItemCellControllerOutput {
    func selection(viewModel: ItemViewModel) {
        controller?.dismiss(animated: true, completion: { [weak self] in
            self?.controller?.onMinimizeTapped()
            self?.openDeepLinkURL(viewModel.deeplinkUrl)
        })
    }
}

extension ItemsFlow {
    func openDeepLinkURL(_ url: URL?) {
        guard let url = url else {
            print("Invalid URL")
            return
        }

        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                if success {
                    print("URL was opened successfully")
                } else {
                    print("Failed to open URL")
                }
            })
        } else {
            print("Cannot open URL, please check the scheme is correct and allowed in Info.plist")
        }
    }
}

