//
//  FrameAccessor.swift
//  LazySwifter
//
//  Created by Quoc Nguyen on 2/6/18.
//

import UIKit

public extension UIView {
    public var width: CGFloat {
        get {
            return self.bounds.width
        }
        set {
            var frame = self.bounds
            frame.size.width = newValue
            self.bounds = frame
        }
    }

    public var height: CGFloat {
        get {
            return self.bounds.height
        }
        set {
            var frame = self.bounds
            frame.size.height = newValue
            self.bounds = frame
        }
    }

    public var x: CGFloat {
        get {
            return self.frame.minX
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }

    public var y: CGFloat {
        get {
            return self.frame.minY
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }

    public var origin: CGPoint {
        get {
            return self.frame.origin
        }
        set {
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
    }

    public var size: CGSize {
        get {
            return self.bounds.size
        }
        set {
            var frame = self.bounds
            frame.size = newValue
            self.bounds = frame
        }
    }

    public var mid: CGPoint {
        return CGPoint(x: self.width/2, y: self.height/2)
    }
}

