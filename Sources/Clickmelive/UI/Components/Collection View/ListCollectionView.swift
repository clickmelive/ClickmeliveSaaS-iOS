//
//  ListCollectionView.swift
//  ClickmeliveUI
//
//  Created by Can on 3.03.2024.
//

import UIKit

extension ListCollectionView {
    func display(_ cellControllers: [CollectionCellController]) {
        loadingControllers = [:]
        collectionModel = cellControllers
        reloadData()
    }
    
    func appendCellControllers(_ cellControllers: [CollectionCellController]) {
        // Initialize an array to hold new cell controllers that are not already present
        var uniqueNewControllers = [CollectionCellController]()
        
        // Iterate over the incoming cell controllers
        for newController in cellControllers.reversed() {
            // Check if the newController is not already in the collectionModel
            if !collectionModel.contains(where: { existingController in
                existingController.id == newController.id
            }) {
                // If it's unique, prepend it to the uniqueNewControllers array
                // We're prepending here because we're iterating the cellControllers in reverse
                uniqueNewControllers.insert(newController, at: 0)
            }
        }
        
        // Check if there are any unique new controllers to add
        guard !uniqueNewControllers.isEmpty else { return }

        // Prepend the unique new cell controllers to the collection model
        collectionModel.insert(contentsOf: uniqueNewControllers, at: 0)
        
        // Perform updates on the collection view
        performBatchUpdates({
            // Calculate the new index paths for the inserted cells
            let indexPaths = (0..<uniqueNewControllers.count).map { IndexPath(item: $0, section: 0) }
            
            // Insert the new items at the calculated index paths
            insertItems(at: indexPaths)
        }, completion: nil)
    }

    
    func didScroll(threshold: CGFloat) -> Bool {
        return abs(self.contentOffset.y) >= threshold
    }
}

class ListCollectionView: UICollectionView {
    
    var numberOfItems: Int { return collectionModel.count }
    var scrollViewDidScroll: ((_ scrollView: UIScrollView) -> Void)?
    
    private var loadingControllers = [IndexPath: CollectionCellController]()
    
    var collectionModel = [CollectionCellController]()
    
    init(layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
        
        self.delegate = self
        self.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListCollectionView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let ds = cellController(forItemAt: indexPath).dataSource
        return ds.collectionView(collectionView, cellForItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dl = cellController(forItemAt: indexPath).delegate
        dl?.collectionView?(collectionView, didSelectItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let dl = cellController(forItemAt: indexPath).delegate
        dl?.collectionView?(collectionView, willDisplay: cell, forItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let dl = removeLoadingController(forItemAt: indexPath)?.delegate
        dl?.collectionView?(collectionView, didEndDisplaying: cell, forItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dfl = cellController(forItemAt: indexPath).delegateFlowLayout
        return dfl?.collectionView?(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath) ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        guard !collectionModel.isEmpty else { return .zero }
        
        let dfl = cellController(forItemAt: IndexPath(item: 0, section: section)).delegateFlowLayout
        return dfl?.collectionView?(collectionView, layout: collectionViewLayout, minimumLineSpacingForSectionAt: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        guard !collectionModel.isEmpty else { return .zero }
        
        let dfl = cellController(forItemAt: IndexPath(item: 0, section: section)).delegateFlowLayout
        return dfl?.collectionView?(collectionView, layout: collectionViewLayout, minimumInteritemSpacingForSectionAt: section) ?? 0
    }
    
    private func cellController(forItemAt indexPath: IndexPath) -> CollectionCellController {
        let controller = collectionModel[indexPath.item]
        loadingControllers[indexPath] = controller
        return controller
    }
    
    private func removeLoadingController(forItemAt indexPath: IndexPath) -> CollectionCellController? {
        let controller = loadingControllers[indexPath]
        loadingControllers[indexPath] = nil
        return controller
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollViewDidScroll?(scrollView)
    }
}

