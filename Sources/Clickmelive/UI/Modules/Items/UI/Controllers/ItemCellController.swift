//
//  ItemCellController.swift
//  ClickmeliveUI
//
//  Created by Can on 3.03.2024.
//

import UIKit

protocol ItemCellControllerOutput {
    func selection(viewModel: ItemViewModel)
}

final class ItemCellController: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private enum Constants {
        static let cellHeight: CGFloat = 120.0
    }
    
    private var itemCell = Components.default.itemCell
    
    var output: ItemCellControllerOutput?
    
    private let viewModel: ItemViewModel
    private let imageLoader: ImageLoader
    
    init(viewModel: ItemViewModel,
         imageLoader: ImageLoader) {
        self.viewModel = viewModel
        self.imageLoader = imageLoader
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: itemCell.self, for: indexPath)
        cell.configure(with: viewModel, imageLoader: imageLoader)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width, height: Constants.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output?.selection(viewModel: viewModel)
    }
}

