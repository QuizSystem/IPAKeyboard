//
//  CGSizeExtension.swift
//  LazySwifter
//
//  Created by Quoc Nguyen on 2/6/18.
//

import UIKit

public extension CGSize {
    public static func * (size: CGSize, times: CGFloat) -> CGSize {
        return CGSize(width: size.width * times, height: size.height * times)
    }

    public static func *= (size: inout CGSize, times: CGFloat) {
        size = size * times
    }

    public static func / (size: CGSize, times: CGFloat) -> CGSize {
        return CGSize(width: size.width / times, height: size.height / times)
    }

    public static func /= (size: inout CGSize, times: CGFloat) {
        size = size / times
    }

    public static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }

    public static func += (size: inout CGSize, added: CGSize) {
        size = size + added
    }

    public static func - (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }

    public static func -= (size: inout CGSize, added: CGSize) {
        size = size + added
    }
}
