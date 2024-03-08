//
//  ChatView.swift
//  ClickmeliveUI
//
//  Created by Can on 4.03.2024.
//

import UIKit

extension ChatView {
    func configure(with viewModel: VideoViewModel) {
        isHidden = true
    }
}

extension ChatView {
    func configure(with viewModel: LiveEventViewModel) {
        isHidden = viewModel.status != .Streaming
    }
}

extension ChatView {
    func display(chatMessages: [CollectionCellController]) {
        if chatList.didScroll(threshold: scrollThreshold) {
            chatList.appendCellControllers(chatMessages)
        } else {
            chatList.display(chatMessages)
            chatList.scrollToItem(at: IndexPath(item: 0, section: 0), at: .bottom, animated: true)
        }
    }
    
    private func registerActions() {
        chatList.scrollViewDidScroll = { [weak self] scrollView in
            guard let self = self else { return }
            btnScrollDown.isHidden = !chatList.didScroll(threshold: scrollThreshold)
        }
        
        btnScrollDown.addTarget(self, action: #selector(btnScrollDownTapped), for: .touchUpInside)
    }
    
    @objc private func btnScrollDownTapped() {
        chatList.scrollToItem(at: IndexPath(item: 0, section: 0), at: .bottom, animated: true)
    }
}

class ChatView: _View {
    
    private var scrollThreshold: CGFloat = 50
    
    private(set) lazy var chatList: ListCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let cv = ListCollectionView(layout: layout)
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.transform = CGAffineTransform(scaleX: 1, y: -1)
        cv.contentInset = .init(top: 8, left: 0, bottom: 0, right: 0)
        return cv
    }()
    
    private(set) lazy var btnScrollDown: UIButton = {
        let iv = UIButton()
        return iv
    }()
    
    override func setUp() {
        super.setUp()
        registerActions()
    }
    
    override func setUpAppearance() {
        super.setUpAppearance()
        btnScrollDown.isHidden = true
    }
    
    override func setUpLayout() {
        super.setUpLayout()
        
        [chatList, btnScrollDown].forEach {
            addSubview($0)
        }
        
        btnScrollDown.anchor(bottom: bottomAnchor, right: rightAnchor, bottomConstant: 8, widthConstant: 36, heightConstant: 36)
        
        chatList.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: btnScrollDown.leftAnchor, rightConstant: 8)
    }
    
    override func updateContent() {
        super.updateContent()
        btnScrollDown.setImage(.appImage(.iconScrollDown), for: .normal)
    }
}
