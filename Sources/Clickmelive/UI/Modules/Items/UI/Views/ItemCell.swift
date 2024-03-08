//
//  ItemCell.swift
//  ClickmeliveUI
//
//  Created by Can on 3.03.2024.
//

import UIKit

class ItemCell: _CollectionViewCell {
    class var reuseId: String { String(describing: self) }
    
    func configure(with viewModel: ItemViewModel, imageLoader: ImageLoader) {
        lblName.text = viewModel.name
        imageLoader.loadImage(to: ivItem, with: viewModel.imageURL, placeholder: nil)
    }
    
    private(set) lazy var ivItem: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    private(set) lazy var lblName: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private(set) lazy var ivArrow: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    private(set) lazy var line: UIView = {
        let view = UIView()
        return view
    }()
    
    override func setUp() {
        super.setUp()
        ivItem.contentMode = .scaleAspectFill
        ivItem.clipsToBounds = true
        lblName.numberOfLines = 4
    }
    
    override func setUpAppearance() {
        super.setUpAppearance()
        ivItem.layer.cornerRadius = 10
        
        line.backgroundColor = .appColor(.appSeperator)
        
        lblName.textColor = .appColor(.appSecondaryText)
        lblName.font = .appFont(.medium, size: 14)
    }
    
    override func setUpLayout() {
        super.setUpLayout()
        
        [ivItem, lblName, ivArrow, line].forEach {
            contentView.addSubview($0)
        }
        
        ivItem.anchor(left: contentView.leftAnchor, leftConstant: 16, widthConstant: 112, heightConstant: 87)
        ivItem.anchorCenterYToSuperview()
        
        ivArrow.anchor(right: contentView.rightAnchor, rightConstant: 16, widthConstant: 14, heightConstant: 27)
        ivArrow.anchorCenterYToSuperview()
        
        lblName.anchor(left: ivItem.rightAnchor, right: ivArrow.leftAnchor, leftConstant: 23, rightConstant: 23)
        lblName.anchorCenterYToSuperview()
        
        line.anchor(left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, leftConstant: 16, rightConstant: 16, heightConstant: 2)
    }
    
    override func updateContent() {
        super.updateContent()
        ivArrow.image = .appImage(.iconRightArrow)
    }
}
