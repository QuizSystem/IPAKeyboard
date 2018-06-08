//
//  UIViewExtension.swift
//  LazySwifter
//
//  Created by Quoc Nguyen on 2/6/18.
//

import UIKit

extension UIView {
    public class var identifier: String {
        return String(describing: self)
    }

    public class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    public var identifier: String {
        return String(describing: type(of: self))
    }

    public func loadXib() {
        let nibData = Bundle.main.loadNibNamed(
            self.identifier, owner: self, options: nil
        )
        guard let content = nibData?.first as? UIView else {
            return
        }
        self.addSubview(content)
        content.frame = self.bounds
        func addConstrain(attribute: NSLayoutAttribute, of: UIView) {
            let constraint = NSLayoutConstraint(
                item: content, attribute: attribute,
                relatedBy: .equal, toItem: self,
                attribute: attribute, multiplier: 1.0, constant: 0.0
            )
            self.addConstraint(constraint)
        }
        addConstrain(attribute: .left, of: content)
        addConstrain(attribute: .right, of: content)
        addConstrain(attribute: .top, of: content)
        addConstrain(attribute: .bottom, of: content)
    }

    public func removeAllGestureRecognize() {
        self.gestureRecognizers?.forEach({ (gesture) in
            self.removeGestureRecognizer(gesture)
        })
    }

    public var shadowColor: UIColor? {
        get {
            guard let v = layer.shadowColor else {
                return nil
            }

            return UIColor(cgColor: v)
        }
        set(value) {
            layer.shadowColor = value?.cgColor
        }
    }

    public var borderColor: UIColor? {
        get {
            guard let v = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: v)
        }
        set(value) {
            layer.borderColor = value?.cgColor
        }
    }

    public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set(value) {
            layer.borderWidth = value
        }
    }

    public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set(value) {
            layer.cornerRadius = value
            self.clipsToBounds = true
        }
    }

    public func capture() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        self.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
