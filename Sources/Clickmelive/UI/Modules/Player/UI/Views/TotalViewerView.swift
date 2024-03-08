//
//  TotalViewerView.swift
//  ClickmeliveUI
//
//  Created by Can on 4.03.2024.
//

import UIKit

private extension LiveEventViewModel {
    var backgroundColor: UIColor {
        guard !replayAvailable else {
            return .appColor(.appDimmedBackground)
        }

        switch status {
        case .Created, .Teaser, .ReadyToStream, .Cancelled, .None:
            return .appColor(.appDimmedBackground)
        case .Streaming, .StreamEnded:
            return .appColor(.appRed)
        }
    }
    
    var shouldUpdateUsingTotalViewer: Bool {
        status != .Streaming
    }
}

extension TotalViewerView {
    func configure(viewModel: VideoViewModel) {
        backgroundColor = .appColor(.appDimmedBackground)
        lblViewerCount.text = viewModel.totalViewer
    }
}

extension TotalViewerView {
    func configure(viewModel: LiveEventViewModel) {
        backgroundColor = viewModel.backgroundColor
        
        if viewModel.shouldUpdateUsingTotalViewer {
            lblViewerCount.text = viewModel.totalViewer
        }
    }
    
    func configure(viewModel: LiveEventViewerViewModel) {
        lblViewerCount.text = viewModel.viewerCount
        isHidden = viewModel.isViewerCountHidden
    }
}

class TotalViewerView: _View {
    
    var viewHeight: CGFloat { return 22 }
    
    private(set) lazy var ivViewer: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    private(set) lazy var lblViewerCount: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func setUpAppearance() {
        super.setUpAppearance()
        layer.cornerRadius = 8
       
        lblViewerCount.font = .appFont(.medium, size: 12)
        lblViewerCount.textColor = .appColor(.appPrimaryText)
    }
    
    override func setUpLayout() {
        super.setUpLayout()
      
        [ivViewer, lblViewerCount].forEach {
            addSubview($0)
        }
       
        ivViewer.anchor(left: leftAnchor, leftConstant: 8, widthConstant: 13, heightConstant: 10)
        ivViewer.anchorCenterYToSuperview()
        
        lblViewerCount.anchor(left: ivViewer.rightAnchor, right: rightAnchor, leftConstant: 3, rightConstant: 8)
        lblViewerCount.anchorCenterYToSuperview()
        
        constrainHeight(viewHeight)
    }
    
    override func updateContent() {
        super.updateContent()
        ivViewer.image = .appImage(.iconViewers)
    }
}
