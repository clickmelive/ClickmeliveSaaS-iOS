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
    
    private(set) lazy var handleArea: UIView = {
        let view = UIView()
        return view
    }()
    
    private(set) lazy var lblItemCount: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private(set) lazy var itemsList: ListCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = ListCollectionView(layout: layout)
        return cv
    }()
    
    override func setUp() {
        super.setUp()
        itemsList.contentInset = .init(top: 0, left: 0, bottom: 16, right: 0)
    }
    
    override func setUpAppearance() {
        super.setUpAppearance()
       
        backgroundColor = .appColor(.appBackground)
        
        handleArea.backgroundColor = .appColor(.appBlack).withAlphaComponent(0.5)
        handleArea.layer.cornerRadius = 2
        
        lblItemCount.textColor = .appColor(.appBlack).withAlphaComponent(0.5)
        lblItemCount.font = .appFont(.medium, size: 12)
        
        itemsList.backgroundColor = .clear
    }
    
    override func setUpLayout() {
        super.setUpLayout()
        
        [handleArea, lblItemCount, itemsList].forEach {
            addSubview($0)
        }
        
        handleArea.anchor(top: topAnchor, topConstant: 13, widthConstant: 49, heightConstant: 4)
        handleArea.anchorCenterXToSuperview()
        
        lblItemCount.anchor(top: handleArea.bottomAnchor, left: leftAnchor, right: rightAnchor, topConstant: 4, leftConstant: 16, rightConstant: 16)
        
        itemsList.anchor(top: lblItemCount.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 4)
    }
}
