//
//  ItemsViewController.swift
//  ClickmeliveUI
//
//  Created by Can on 3.03.2024.
//

import UIKit

final class ItemsViewController: UIViewController {
    
    private lazy var itemsVCView = Components.default.itemsVCView.init()
    private lazy var itemCell = Components.default.itemCell
    
    deinit {
        print("deinit ItemsViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func loadView() {
        view = itemsVCView
    }
}

extension ItemsViewController {
    func display(_ items: [CollectionCellController]) {
        itemsVCView.itemsList.display(items)
    }
    
    private func setupCollectionView() {
        itemsVCView.itemsList.register(itemCell, forCellWithReuseIdentifier: itemCell.reuseId)
    }
}
