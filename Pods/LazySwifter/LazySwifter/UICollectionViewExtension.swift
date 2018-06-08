//
//  UICollectionViewExtension.swift
//  LazySwifter
//
//  Created by Quoc Nguyen on 2/6/18.
//

import UIKit

extension UICollectionView {
    public func register<T: UICollectionViewCell>(_ cellType: T.Type, fromNib: Bool = true) {
        if fromNib {
            self.register(cellType.nib, forCellWithReuseIdentifier: cellType.identifier)
        } else {
            self.register(cellType.self, forCellWithReuseIdentifier: cellType.identifier)
        }
    }

    public func reuseCell<T: UICollectionViewCell>(_ cellType: T.Type, for indexPath: IndexPath) -> T {
        let reuseCell = self.dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath)
        return reuseCell as? T ?? T()
    }
}
