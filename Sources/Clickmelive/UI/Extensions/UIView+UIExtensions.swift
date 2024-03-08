//
//  UIView+Extensions.swift
//  ClickmeliveUI
//
//  Created by Can on 3.03.2024.
//

import UIKit

// MARK: - Layout related methods extended with pinning functionality

extension UIView {

    // Adds constraints using Visual Format Language
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    // Fills the superview with the current view, applying streamRequire priority
    func fillSuperview() {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.pin(equalTo: superview.leadingAnchor).isActive = true
        trailingAnchor.pin(equalTo: superview.trailingAnchor).isActive = true
        topAnchor.pin(equalTo: superview.topAnchor).isActive = true
        bottomAnchor.pin(equalTo: superview.bottomAnchor).isActive = true
    }
    
    // Sets anchors with the ability to specify constants for each side and size, applying streamRequire priority
    func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.pin(equalTo: top, constant: topConstant).isActive = true
        }
        if let left = left {
            leftAnchor.pin(equalTo: left, constant: leftConstant).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.pin(equalTo: bottom, constant: -bottomConstant).isActive = true
        }
        if let right = right {
            rightAnchor.pin(equalTo: right, constant: -rightConstant).isActive = true
        }
        if widthConstant > 0 {
            constrainWidth(widthConstant)
        }
        if heightConstant > 0 {
            constrainHeight(heightConstant)
        }
    }
    
    // Centers the view in its superview along the X axis, applying streamRequire priority
    func anchorCenterXToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerXAnchor {
            centerXAnchor.pin(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    // Centers the view in its superview along the Y axis, applying streamRequire priority
    func anchorCenterYToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerYAnchor {
            centerYAnchor.pin(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    // Centers the view in its superview both horizontally and vertically
    func anchorCenterSuperview() {
        anchorCenterXToSuperview()
        anchorCenterYToSuperview()
    }
    
    func anchorLessThan(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        _ = anchorLessThanWithReturnAnchors(top: top, left: left, bottom: bottom, right: right, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant, widthConstant: widthConstant, heightConstant: heightConstant)
    }
    
    func anchorLessThanWithReturnAnchors(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.pin(lessThanOrEqualTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.pin(lessThanOrEqualTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.pin(lessThanOrEqualTo: bottom, constant: -bottomConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.pin(lessThanOrEqualTo: right, constant: -rightConstant))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.pin(lessThanOrEqualToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.pin(lessThanOrEqualToConstant: heightConstant))
        }
        
        anchors.forEach { $0.isActive = true }
        
        return anchors
    }
    
    // Convenience method to constrain width with streamRequire priority
    @discardableResult
    func constrainWidth(_ constant: CGFloat) -> NSLayoutConstraint {
        let constraint = widthAnchor.pin(equalToConstant: constant)
        constraint.isActive = true
        return constraint
    }
    
    // Convenience method to constrain height with streamRequire priority
    @discardableResult
    func constrainHeight(_ constant: CGFloat) -> NSLayoutConstraint {
        let constraint = heightAnchor.pin(equalToConstant: constant)
        constraint.isActive = true
        return constraint
    }

    // Accessor for the height constraint if it exists
    var heightConstraint: NSLayoutConstraint? {
        get {
            return constraints.first { $0.firstAttribute == .height && $0.relation == .equal }
        }
        set { setNeedsLayout() }
    }

    // Accessor for the width constraint if it exists
    var widthConstraint: NSLayoutConstraint? {
        get {
            return constraints.first { $0.firstAttribute == .width && $0.relation == .equal }
        }
        set { setNeedsLayout() }
    }

    // Additional utility methods can be added here...
}

// Struct to hold references to anchored constraints, for easy adjustment later
struct AnchoredConstraints {
    var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}

