//
//  ItemsVCView.swift
//  ClickmeliveUI
//
//  Created by Can on 3.03.2024.
//

import UIKit

class ItemsVCView: _View {
    
    private(set) lazy var itemsList: ListCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = ListCollectionView(layout: layout)
        cv.backgroundColor = .clear
        cv.contentInset = .init(top: 16, left: 0, bottom: 16, right: 0)
        return cv
    }()
    
    override func setUp() {
        super.setUp()
        backgroundColor = .appColor(.appBackground)
    }
    
    override func setUpLayout() {
        super.setUpLayout()
        addSubview(itemsList)
        itemsList.fillSuperview()
    }
}
