//
//  UITableViewExtension.swift
//  LazySwifter
//
//  Created by Quoc Nguyen on 2/6/18.
//

import UIKit

extension UITableView {
    public func register<T: UITableViewCell>(_ cellType: T.Type, fromNib: Bool = true) {
        if fromNib {
            self.register(cellType.nib, forCellReuseIdentifier: cellType.identifier)
        } else {
            self.register(T.self, forCellReuseIdentifier: cellType.identifier)
        }
    }

    public func reuseCell<T: UITableViewCell>(_ cellType: T.Type, for indexPath: IndexPath) -> T {
        let reuse = self.dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath)
        return reuse as? T ?? T()
    }
}
