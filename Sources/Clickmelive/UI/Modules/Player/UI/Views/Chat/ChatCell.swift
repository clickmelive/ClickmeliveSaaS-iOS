//
//  ChatCell.swift
//  ClickmeliveUI
//
//  Created by Can on 4.03.2024.
//

import UIKit

extension ChatCell {
    func configure(with viewModel: ChatMessageViewModel) {
        lblDisplayName.text = viewModel.userDisplayName
        lblMessage.text = viewModel.message
    }
}

extension ChatCell {
    static func chatSize(viewModel: ChatMessageViewModel, maxWidth: CGFloat) -> CGSize {
        let font = Constants.font
        
        let usableWidth = maxWidth - (Constants.horizontalPadding * 2)
        
        let messageSize = viewModel.message.stringSize(width: usableWidth, font: font)
        let displaySize = viewModel.userDisplayName.stringSize(width: usableWidth, font: font)
        
        let combinedHeight = messageSize.height + displaySize.height + (Constants.verticalPadding * 2) + Constants.spacingBetweenLabels
        
        return CGSize(width: maxWidth, height: combinedHeight)
    }
}


class ChatCell: _CollectionViewCell {
    class var reuseId: String { String(describing: self) }
    
    private enum Constants {
        static let font: UIFont = .appFont(.medium, size: 13)
        static let horizontalPadding: CGFloat = 16
        static let verticalPadding: CGFloat = 8
        static let spacingBetweenLabels: CGFloat = 4
    }
    
    private(set) lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    private(set) lazy var displayNameContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private(set) lazy var lblDisplayName: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private(set) lazy var messageContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private(set) lazy var lblMessage: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func setUpAppearance() {
        super.setUpAppearance()
        
        contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        containerStackView.backgroundColor = .appColor(.appChatBubbleBg)
        containerStackView.layer.cornerRadius = 24
        containerStackView.axis = .vertical
        containerStackView.distribution = .fill
        
        lblDisplayName.numberOfLines = 0
        lblDisplayName.textColor = .appColor(.appSecondaryText).withAlphaComponent(0.8)
        lblDisplayName.font = Constants.font
        
        lblMessage.numberOfLines = 0
        lblMessage.textColor = .appColor(.appSecondaryText)
        lblMessage.font = Constants.font
    }
    
    override func setUpLayout() {
        super.setUpLayout()
        
        lblDisplayName.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        displayNameContainer.addSubview(lblDisplayName)
        messageContainer.addSubview(lblMessage)
        
        [displayNameContainer, messageContainer].forEach {
            containerStackView.addArrangedSubview($0)
        }
        
        contentView.addSubview(containerStackView)
        containerStackView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor)
       
        containerStackView.anchorLessThan(right: contentView.rightAnchor, rightConstant: 0)
        
        lblDisplayName.anchor(top: displayNameContainer.topAnchor, left: displayNameContainer.leftAnchor, bottom: displayNameContainer.bottomAnchor, right: displayNameContainer.rightAnchor, topConstant: Constants.verticalPadding ,leftConstant: Constants.horizontalPadding, rightConstant: Constants.horizontalPadding)
        
        lblMessage.anchor(top: messageContainer.topAnchor, left: messageContainer.leftAnchor, bottom: messageContainer.bottomAnchor, right: messageContainer.rightAnchor, leftConstant: Constants.horizontalPadding, bottomConstant: Constants.verticalPadding, rightConstant: Constants.horizontalPadding)
    }
}

