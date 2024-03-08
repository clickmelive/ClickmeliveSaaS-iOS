//
//  ItemsView.swift
//  ClickmeliveUI
//
//  Created by Can on 4.03.2024.
//

import UIKit

extension ItemsView {
    func configure(with viewModel: VideoViewModel, imageLoader: ImageLoader) {
        isHidden = viewModel.isItemsHidden
        lblItemCount.text = viewModel.itemsCount
        imageLoader.loadImage(to: ivItem, with: viewModel.firstItemImageURL, placeholder: nil)
    }
}

extension ItemsView {
    func configure(with viewModel: LiveEventViewModel, imageLoader: ImageLoader) {
        isHidden = viewModel.isItemsHidden
        lblItemCount.text = viewModel.itemsCount
        imageLoader.loadImage(to: ivItem, with: viewModel.firstItemImageURL, placeholder: nil)
    }
}

class ItemsView: _View {
    
    var viewSize: CGSize { .init(width: 60, height: 68) }
    
    private(set) lazy var ivItemsContainer: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    private(set) lazy var ivItem: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    private(set) lazy var itemCountContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private(set) lazy var lblItemCount: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func setUpAppearance() {
        super.setUpAppearance()
        
        itemCountContainer.clipsToBounds = true
        itemCountContainer.layer.cornerRadius = 8
        itemCountContainer.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        itemCountContainer.backgroundColor = .appColor(.appPrimary)
        
        ivItem.clipsToBounds = true
        ivItem.layer.cornerRadius = 8
        
        lblItemCount.textAlignment = .center
        lblItemCount.textColor = .appColor(.appPrimaryText)
        lblItemCount.font = .appFont(.bold, size: 8)
    }
    
    override func setUpLayout() {
        super.setUpLayout()
        
        itemCountContainer.addSubview(lblItemCount)
        
        [ivItemsContainer, ivItem, itemCountContainer].forEach {
            addSubview($0)
        }
        
        ivItem.anchor(top: ivItemsContainer.topAnchor, left: ivItemsContainer.leftAnchor, bottom: ivItemsContainer.bottomAnchor, right: ivItemsContainer.rightAnchor, topConstant: 1, leftConstant: 1, bottomConstant: 9, rightConstant: 1)
        
        ivItemsContainer.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, widthConstant: viewSize.width, heightConstant: viewSize.height)
        
        itemCountContainer.anchor(left: ivItemsContainer.leftAnchor, bottom: ivItemsContainer.bottomAnchor, right: ivItemsContainer.rightAnchor, bottomConstant: 8, heightConstant: 18)
        
        lblItemCount.anchor(left: itemCountContainer.leftAnchor, right: itemCountContainer.rightAnchor, leftConstant: 4, rightConstant: 4)
        lblItemCount.anchorCenterYToSuperview()
    }
    
    override func updateContent() {
        super.updateContent()
        ivItemsContainer.image = .appImage(.imgItems)
    }
}

