//
//  TitleView.swift
//  Clickmelive
//
//  Created by Can on 6.03.2024.
//

import UIKit

extension TitleView {
    func configure(with title: String) {
        lblTitle.text = title
    }
}

class TitleView: _View {
    
    var viewSize: CGSize { .init(width: 60, height: 68) }
    
    private(set) lazy var lblTitle: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func setUpAppearance() {
        super.setUpAppearance()
        
        lblTitle.textColor = .appColor(.appPrimaryText)
        lblTitle.font = .appFont(.medium, size: 14)
        lblTitle.numberOfLines = 2
    }
    
    override func setUpLayout() {
        super.setUpLayout()
        
        addSubview(lblTitle)
        lblTitle.fillSuperview()
    }

}
