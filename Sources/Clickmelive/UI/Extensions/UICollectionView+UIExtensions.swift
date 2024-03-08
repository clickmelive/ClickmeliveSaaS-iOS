//
//  UICollectionView+Extensions.swift
//  ClickmeliveUI
//
//  Created by Can on 3.03.2024.
//

import UIKit

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}

extension UICollectionViewCell: Reusable {}

extension UICollectionView {
    /// Registers a UICollectionViewCell from a supplied type
    /// The identifier is used from the reuseIdentifier parameter
    /// - Parameter type: A generic type
    func register<Cell: UICollectionViewCell>(_ type: Cell.Type) {
        register(type, forCellWithReuseIdentifier: type.reuseIdentifier)
    }

    /// Dequeues a UICollectionView Cell with a generic type and indexPath
    /// - Parameters:
    ///   - type: A generic cell type
    ///   - indexPath: The indexPath of the row in the UICollectionView
    /// - Returns: A Cell from the type passed through
    func dequeueReusableCell<Cell: UICollectionViewCell>(with type: Cell.Type, for indexPath: IndexPath, reuseIdentifier: String? = nil) -> Cell {
        dequeueReusableCell(withReuseIdentifier: reuseIdentifier ?? type.reuseIdentifier, for: indexPath) as! Cell
    }
}
