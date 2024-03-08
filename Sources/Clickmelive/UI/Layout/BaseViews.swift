//
//  BaseViews.swift
//  ClickmeliveUI
//
//  Created by Can on 3.03.2024.
//

import UIKit

class _View: UIView, Customizable {
    // Flag for preventing multiple lifecycle methods calls.
    fileprivate var isInitialized: Bool = false

    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard !isInitialized, superview != nil else { return }

        isInitialized = true

        setUp()
        setUpLayout()
        setUpAppearance()
        updateContent()
    }

    open func setUp() { /* default empty implementation */ }
    open func setUpAppearance() { setNeedsLayout() }
    open func setUpLayout() { setNeedsLayout() }
    open func updateContent() { setNeedsLayout() }
}

class _TextView: UITextView, Customizable {
    // Flag for preventing multiple lifecycle methods calls.
    fileprivate var isInitialized: Bool = false

    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard !isInitialized, superview != nil else { return }

        isInitialized = true

        setUp()
        setUpLayout()
        setUpAppearance()
        updateContent()
    }

    open func setUp() { /* default empty implementation */ }
    open func setUpAppearance() { setNeedsLayout() }
    open func setUpLayout() { setNeedsLayout() }
    open func updateContent() { setNeedsLayout() }
}


open class _CollectionViewCell: UICollectionViewCell, Customizable {
    // Flag for preventing multiple lifecycle methods calls.
    private var isInitialized: Bool = false

    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard !isInitialized, superview != nil else { return }

        isInitialized = true

        setUp()
        setUpLayout()
        setUpAppearance()
        updateContent()
    }

    open func setUp() { /* default empty implementation */ }
    open func setUpAppearance() { setNeedsLayout() }
    open func setUpLayout() { setNeedsLayout() }
    open func updateContent() { setNeedsLayout() }
}
