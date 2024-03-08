//
//  CollectionCellController.swift
//  ClickmeliveUI
//
//  Created by Can on 3.03.2024.
//

import UIKit

struct CollectionCellController {
    let id: AnyHashable
    let dataSource: UICollectionViewDataSource
    let delegate: UICollectionViewDelegate?
    let delegateFlowLayout: UICollectionViewDelegateFlowLayout?
    let dataSourcePrefetching: UICollectionViewDataSourcePrefetching?
    
    init(id: AnyHashable, _ dataSource: UICollectionViewDataSource) {
        self.id = id
        self.dataSource = dataSource
        self.delegate = dataSource as? UICollectionViewDelegate
        self.delegateFlowLayout = dataSource as? UICollectionViewDelegateFlowLayout
        self.dataSourcePrefetching = dataSource as? UICollectionViewDataSourcePrefetching
    }
}

extension CollectionCellController: Equatable {
    static func == (lhs: CollectionCellController, rhs: CollectionCellController) -> Bool {
        lhs.id == rhs.id
    }
}

extension CollectionCellController: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
