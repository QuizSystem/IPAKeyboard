//
//  UIViewControllerExtension.swift
//  LazySwifter
//
//  Created by Quoc Nguyen on 2/6/18.
//
import UIKit

extension UIViewController {
    public static var identifier: String {
        return String(describing: self)
    }

    public static func controller<T: UIViewController>(type: T.Type, at storyboardName: String = "Main") -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let identifier = T.identifier
        return storyboard.instantiateViewController(withIdentifier: identifier) as? T ?? T()
    }

    public func push<T: UIViewController>(_ type: T.Type, configure: ((T) -> Void)?) {
        let vc = UIViewController.controller(type: type)
        configure?(vc)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    public func present<T: UIViewController>(_ type: T.Type, _ hasNavigation: Bool, configure: ((T) -> Void)?) {
        let vc = UIViewController.controller(type: type)
        let presentVC: UIViewController!
        if hasNavigation {
            let nav = UINavigationController(rootViewController: vc)
            presentVC = nav
        } else {
            presentVC = vc
        }
        configure?(vc)
        self.present(presentVC, animated: true, completion: nil)
    }
}
