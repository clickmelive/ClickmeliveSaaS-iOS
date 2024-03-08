//
//  PlayerVCView.swift
//  ClickmeliveUI
//
//  Created by Can on 4.03.2024.
//

import UIKit

extension PlayerVCView {
    func configure(with viewModel: VideoViewModel, imageLoader: ImageLoader) {
        titleView.configure(with: viewModel.title)
        
        itemsView.configure(with: viewModel, imageLoader: imageLoader)
        playerView.configure(with: viewModel, imageLoader: imageLoader)
        statusView.configure(with: viewModel)
        totalViewerView.configure(viewModel: viewModel)
        likeView.configure(with: viewModel)
        chatView.configure(with: viewModel)
        composerView.configure(with: viewModel)
    }
    
    func updateStats(with viewModel: VideoViewModel) {
        totalViewerView.configure(viewModel: viewModel)
        likeView.configure(with: viewModel)
    }
}

extension PlayerVCView {
    func configure(with viewModel: LiveEventViewModel, imageLoader: ImageLoader) {
        titleView.configure(with: viewModel.title)
        
        totalViewerView.configure(viewModel: viewModel)
        likeView.configure(with: viewModel)
        statusView.configure(with: viewModel)
        
        playerView.configure(with: viewModel, imageLoader: imageLoader)
        itemsView.configure(with: viewModel, imageLoader: imageLoader)
        
        chatView.configure(with: viewModel)
        composerView.configure(with: viewModel)
    }
    
    func updateStats(with viewModel: LiveEventViewModel) {
        totalViewerView.configure(viewModel: viewModel)
        likeView.configure(with: viewModel)
    }
    
    func updateLiveEventViewerCount(with viewModel: LiveEventViewerViewModel) {
        totalViewerView.configure(viewModel: viewModel)
    }
}

extension PlayerVCView {
    func updateLikeStatus(with like: Bool, withAnimation: Bool) {
        likeView.updateLikeStatus(with: like, withAnimation: withAnimation)
    }
}

extension PlayerVCView {
    func handleChatView(isKeyboardShowing: Bool, keyboardHeight: CGFloat) {
        chatViewBottomConstraint?.constant = isKeyboardShowing ?
        keyboardHeight - 50 : -(bottomSpace + 164)
    }
}

class PlayerVCView: _View {
    
    private(set) var tvMessageBottomConstraint: NSLayoutConstraint?
    private(set) var chatViewBottomConstraint: NSLayoutConstraint?
    
    private var bottomSpace = UIApplication.safeAreaInsets.bottom
    
    private(set) lazy var playerView: PlayerView = {
        let view = Components.default.playerView.init()
        return view
    }()
    
    private(set) lazy var pipInteractionOverlay: UIView = {
        let view = UIView()
        return view
    }()
    
    private(set) lazy var btnPipClose: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private(set) lazy var btnMinimize: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private(set) lazy var titleView: TitleView = {
        let view = TitleView()
        return view
    }()
    
    private(set) lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    private(set) lazy var itemsView: ItemsView = {
        let view = Components.default.itemsView.init()
        return view
    }()
    
    private(set) lazy var composerViewContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private(set) lazy var composerView: ComposerView = {
        let view = Components.default.composerView.init()
        return view
    }()
    
    private(set) lazy var totalViewerView: TotalViewerView = {
        let view = Components.default.totalViewerView.init()
        return view
    }()
    
    private(set) lazy var likeView: LikeView = {
        let view = Components.default.likeView.init()
        return view
    }()
    
    private(set) lazy var statusView: StatusView = {
        let view = Components.default.statusView.init()
        return view
    }()
    
    private(set) lazy var chatView: ChatView = {
        let view = Components.default.chatView.init()
        return view
    }()
    
    private(set) lazy var tvMessage: MessageTextView = {
        let tv = Components.default.messageTextView.init()
        return tv
    }()
    
    override func setUpAppearance() {
        super.setUpAppearance()
        
        clipsToBounds = true
        backgroundColor = .appColor(.appBlack)
        
        chatView.isHidden = true
        composerView.isHidden = true
        
        bottomStackView.axis = .horizontal
        bottomStackView.spacing = 16
        bottomStackView.distribution = .fill
        
        tvMessage.isHidden = true
        pipInteractionOverlay.isHidden = true
    }
    
    
    override func setUpLayout() {
        super.setUpLayout()
      
        composerViewContainer.addSubview(composerView)
        
        [itemsView, composerViewContainer].forEach {
            bottomStackView.addArrangedSubview($0)
        }
        
        pipInteractionOverlay.addSubview(btnPipClose)
        
        [playerView, btnMinimize, titleView, bottomStackView, statusView, totalViewerView, likeView, chatView, tvMessage, pipInteractionOverlay].forEach {
            addSubview($0)
        }
        
        playerView.fillSuperview()
        
        btnMinimize.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, topConstant: 28, leftConstant: 16, widthConstant: 20, heightConstant: 20)
        
        titleView.anchor(top: btnMinimize.bottomAnchor, left: leftAnchor, topConstant: 16, leftConstant: 16)
        addConstraint(NSLayoutConstraint(item: titleView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.5, constant: 1.0))
        
        bottomStackView.anchor(left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, leftConstant: 16, bottomConstant: 30, rightConstant: 16)
        
        composerView.anchor(left: composerViewContainer.leftAnchor, bottom: composerViewContainer.bottomAnchor, right: composerViewContainer.rightAnchor)
        
        statusView.anchor(left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, leftConstant: 16, bottomConstant: 120)
        
        totalViewerView.anchor(top: safeAreaLayoutGuide.topAnchor, right: rightAnchor, topConstant: 28, rightConstant: 16)
        
        likeView.anchor(bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, bottomConstant: 100, rightConstant: 22)
        
        tvMessageBottomConstraint = NSLayoutConstraint(item: tvMessage, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        addConstraint(tvMessageBottomConstraint!)
        
        chatViewBottomConstraint = NSLayoutConstraint(item: chatView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -(bottomSpace + 164))
        addConstraint(chatViewBottomConstraint!)
        
        chatView.anchor(left: leftAnchor, right: rightAnchor, leftConstant: 16, rightConstant: 80, heightConstant: 240)
        
        tvMessage.anchor(left: leftAnchor, right: rightAnchor)
        
        pipInteractionOverlay.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor)
        
        btnPipClose.anchor(top: pipInteractionOverlay.topAnchor, left: pipInteractionOverlay.leftAnchor, topConstant: 8, leftConstant: 8, widthConstant: 20, heightConstant: 20)
    }
    
    override func updateContent() {
        super.updateContent()
        btnMinimize.setImage(.appImage(.iconMinimize), for: .normal)
        btnPipClose.setImage(.appImage(.iconPipClose), for: .normal)
    }
}

