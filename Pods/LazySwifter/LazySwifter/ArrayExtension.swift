//
//  ArrayExtension.swift
//  LazySwifter
//
//  Created by Quoc Nguyen on 2018/06/04.
//

import UIKit

extension Array {
    public func safe(_ index: Int) -> Element? {
        if self.count > index {
            return self[index]
        }
        return nil
    }
}
