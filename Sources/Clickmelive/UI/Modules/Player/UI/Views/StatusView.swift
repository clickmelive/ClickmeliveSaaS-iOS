//
//  StatusView.swift
//  ClickmeliveUI
//
//  Created by Can on 4.03.2024.
//

import UIKit

extension StatusView {
    func configure(with viewModel: VideoViewModel) {
        ivStatus.image = .appImage(.iconVideo)
        lblStatus.text = viewModel.statusTitle
    }
}

extension StatusView {
    func configure(with viewModel: LiveEventViewModel) {
        
        lblStatus.text = viewModel.statusTitle
        ivStatus.image = viewModel.replayAvailable ?
                        .appImage(.iconVideo):
                        .appImage(.iconLive)
    }
}

class StatusView: _View {
    
    var viewHeight: CGFloat { return 28 }
    
    private(set) lazy var ivStatus: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    private(set) lazy var lblStatus: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func setUpAppearance() {
        super.setUpAppearance()
        
        backgroundColor = .appColor(.appDimmedBackground)
        layer.cornerRadius = 6
        
        ivStatus.layer.cornerRadius = 6
        ivStatus.clipsToBounds = true
        
        lblStatus.font = .appFont(.bold, size: 12)
        lblStatus.textColor = .appColor(.appPrimaryText)
    }
    
    override func setUpLayout() {
        super.setUpLayout()
     
        constrainHeight(viewHeight)
        
        [ivStatus, lblStatus].forEach {
            addSubview($0)
        }
        
        ivStatus.anchor(left: leftAnchor, leftConstant: 8, widthConstant: 20, heightConstant: 20)
        ivStatus.anchorCenterYToSuperview()
        
        lblStatus.anchor(left: ivStatus.rightAnchor, right: rightAnchor, leftConstant: 6, rightConstant: 8)
        lblStatus.anchorCenterYToSuperview()
    }
}

