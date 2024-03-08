//
//  MessageTextView.swift
//  ClickmeliveUI
//
//  Created by Can on 4.03.2024.
//

import UIKit

extension MessageTextView {
    private func registerActions() {
        btnMessage.addTarget(self, action: #selector(sendTapped), for: .touchUpInside)
        
        autoSizingTextView.customTextViewDidChange = { [weak self] textView in
            self?.setSendButtonState(isEnabled: !textView.text.isEmpty)
            self?.onMessageTextChange?(textView.text)
        }
    }
    
    @objc func sendTapped() {
        guard !autoSizingTextView.text.isEmpty else { return }
        onSendMessage?(autoSizingTextView.text)
        autoSizingTextView.clearText()
    }
    
    func setSendButtonState(isEnabled: Bool) {
        btnMessage.isEnabled = isEnabled
        btnMessage.alpha = isEnabled ? 1.0: 0.3
    }
}

final class MessageTextView: _View {
   
    var onSendMessage: ((String) -> Void)?
    var onMessageTextChange: ((String) -> Void)?
    
    private(set) lazy var autoSizingTextView: AutoSizingTextView = {
        let tv = AutoSizingTextView()
        tv.placeholder = "Yazmaya Başla..."
        return tv
    }()
    
    private(set) lazy var btnMessage: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override func setUp() {
        super.setUp()
        registerActions()
    }
    
    override func setUpAppearance() {
        super.setUpAppearance()
        
        backgroundColor = .appColor(.appBlack)
        
        autoSizingTextView.layer.cornerRadius = 12
        autoSizingTextView.backgroundColor = .appColor(.appBackground)
        autoSizingTextView.textColor = .appColor(.appSecondaryText)
        autoSizingTextView.font = .appFont(.regular, size: 13)
        autoSizingTextView.placeholderColor = .appColor(.appSecondaryText)
        autoSizingTextView.placeholderFont = .appFont(.regular, size: 13)
    }
    
    override func setUpLayout() {
        super.setUpLayout()
        [autoSizingTextView, btnMessage].forEach {
            addSubview($0)
        }
        
        btnMessage.anchor(right: rightAnchor, rightConstant: 12, widthConstant: 31, heightConstant: 31)
        
        autoSizingTextView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: btnMessage.leftAnchor, topConstant: 8, leftConstant: 12, bottomConstant: 8, rightConstant: 6)
        
        addConstraint(NSLayoutConstraint(item: btnMessage, attribute: .centerY, relatedBy: .equal, toItem: autoSizingTextView, attribute: .centerY, multiplier: 1.0, constant: 0))
    }
    
    override func updateContent() {
        super.updateContent()
        btnMessage.setImage(.appImage(.iconSend), for: .normal)
        setSendButtonState(isEnabled: false)
    }
}
