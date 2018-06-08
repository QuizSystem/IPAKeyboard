//
//  IntExtension.swift
//  LazySwifter
//
//  Created by Quoc Nguyen on 2/14/18.
//

import Foundation
import Darwin

infix operator **
public extension Int {
    public static func ** (lhs: Int, rhs: Int) -> Double {
        return pow(Double(lhs), Double(rhs))
    }
}
