//
//  ItemsVCView.swift
//  ClickmeliveUI
//
//  Created by Can on 3.03.2024.
//

import UIKit

extension ItemsVCView {
    func setItemCount(_ count: Int, localization: ItemLocalization) {
        lblItemCount.text = localization.itemsCount(count)
    }
}

class ItemsVCView: _View {
    
    private(set) lazy var lblItemCount: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private(set) lazy var itemsList: ListCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = ListCollectionView(layout: layout)
        cv.backgroundColor = .clear
        cv.contentInset = .init(top: 0, left: 0, bottom: 16, right: 0)
        return cv
    }()
    
    override func setUpAppearance() {
        super.setUpAppearance()
        backgroundColor = .appColor(.appBackground)
        
        lblItemCount.textColor = .appColor(.appBlack).withAlphaComponent(0.5)
        lblItemCount.font = .appFont(.medium, size: 12)
    }
    
    override func setUpLayout() {
        super.setUpLayout()
        
        [lblItemCount, itemsList].forEach {
            addSubview($0)
            
        }
        
        lblItemCount.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, right: rightAnchor, topConstant: 19, leftConstant: 16, rightConstant: 16)
        
        itemsList.anchor(top: lblItemCount.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
}
