//
//  CGPointExtension.swift
//  LazySwifter
//
//  Created by Quoc Nguyen on 2/6/18.
//

import UIKit

public extension CGPoint {
    public static func + (point1: CGPoint, point2: CGPoint) -> CGPoint {
        return CGPoint(x: point1.x + point2.x, y: point1.y + point2.y)
    }

    public static func - (point1: CGPoint, point2: CGPoint) -> CGPoint {
        return CGPoint(x: point1.x - point2.x, y: point1.y - point2.y)
    }

    public static func * (point: CGPoint, times: CGFloat) -> CGPoint {
        return CGPoint(x: point.x * times, y: point.y * times)
    }

    public static func / (point: CGPoint, times: CGFloat) -> CGPoint {
        return CGPoint(x: point.x / times, y: point.y / times)
    }

    public static func += (point: inout CGPoint, added: CGPoint) {
        point = point + added
    }

    public static func -= (point: inout CGPoint, added: CGPoint) {
        point = point - added
    }

    public static func *= (point: inout CGPoint, times: CGFloat) {
        point = point * times
    }

    public static func /= (point: inout CGPoint, times: CGFloat) {
        point = point / times
    }
}
