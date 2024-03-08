//
//  AutoSizingTextView.swift
//  ClickmeliveUI
//
//  Created by Can on 4.03.2024.
//

import UIKit

extension AutoSizingTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updatePlaceholder()
        
        let fixedWidth = textView.frame.size.width
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))

        if newSize.height > maxHeight {
            customHeightConstraint?.constant = maxHeight
            textView.isScrollEnabled = true
        } else {
            customHeightConstraint?.constant = newSize.height
            textView.isScrollEnabled = false
        }
        
        if let customTextViewDidChange {
            customTextViewDidChange(textView)
        }
    }
    
    func clearText() {
        text = nil
        customHeightConstraint?.constant = Constants.initialHeight
        textViewDidChange(self)
    }
}

extension AutoSizingTextView {
    func updatePlaceholder() {
        lblPlaceholder.isHidden = !text.isEmpty
    }
}

final class AutoSizingTextView: _TextView {
    
    var customTextViewDidChange: ((UITextView) -> Void)?
    
    private enum Constants {
        static let initialHeight: CGFloat = 33.0
        static let defaultMaxHeight: CGFloat = 76.0
    }
    
    var placeholder: String? {
        get { return lblPlaceholder.text }
        set { lblPlaceholder.text = newValue }
    }
    
    var placeholderColor: UIColor? {
        get { return lblPlaceholder.textColor }
        set { lblPlaceholder.textColor = newValue ?? .lightGray }
    }
    
    var placeholderFont: UIFont? {
        get { return lblPlaceholder.font }
        set { lblPlaceholder.font = newValue ?? .appFont(.regular, size: 13) }
    }
    
    private var customHeightConstraint: NSLayoutConstraint?
    private var maxHeight: CGFloat
    
    convenience init(maxHeight: CGFloat = Constants.defaultMaxHeight) {
        self.init(frame: .zero, textContainer: nil, maxHeight: maxHeight)
    }

    init(frame: CGRect, textContainer: NSTextContainer?, maxHeight: CGFloat = Constants.defaultMaxHeight) {
        self.maxHeight = maxHeight
        super.init(frame: frame, textContainer: textContainer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private(set) lazy var lblPlaceholder: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func setUp() {
        super.setUp()
        
        delegate = self
        isScrollEnabled = false
        spellCheckingType = .no
        textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        updatePlaceholder()
    }
    
    override func setUpAppearance() {
        super.setUpAppearance()
        
        lblPlaceholder.textColor = .appColor(.appPrimaryText)
        lblPlaceholder.font = .appFont(.medium, size: 13)
    }
    
    override func setUpLayout() {
        super.setUpLayout()
        
        customHeightConstraint = self.heightAnchor.constraint(equalToConstant: Constants.initialHeight)
        customHeightConstraint?.isActive = true
        
        addSubview(lblPlaceholder)
        lblPlaceholder.anchor(top: topAnchor, left: leftAnchor, topConstant: 8, leftConstant: 12)
    }
}
