//
//  UIWindow+TopmostViewController.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 03.09.25.
//

import UIKit

extension UIWindow {
    var topmostViewController: UIViewController? {
        guard let rootViewController else { return nil }
        return findTopmostViewController(from: rootViewController)
    }
    
    private func findTopmostViewController(from viewController: UIViewController) -> UIViewController {
        // If presented view controller exists, recurse on it
        if let presentedViewController = viewController.presentedViewController {
            return findTopmostViewController(from: presentedViewController)
        }
        
        // If it's a navigation controller, get the top view controller
        if let navigationController = viewController as? UINavigationController {
            if let topViewController = navigationController.topViewController {
                return findTopmostViewController(from: topViewController)
            }
            return navigationController
        }
        
        // If it's a tab bar controller, get the selected view controller
        if let tabBarController = viewController as? UITabBarController {
            if let selectedViewController = tabBarController.selectedViewController {
                return findTopmostViewController(from: selectedViewController)
            }
            return tabBarController
        }
        
        // If it's a page view controller, get the current view controller
        if let pageViewController = viewController as? UIPageViewController {
            if let currentViewController = pageViewController.viewControllers?.first {
                return findTopmostViewController(from: currentViewController)
            }
            return pageViewController
        }
        
        // If it's a split view controller, get the detail view controller
        if let splitViewController = viewController as? UISplitViewController {
            if let detailViewController = splitViewController.viewControllers.last {
                return findTopmostViewController(from: detailViewController)
            }
            return splitViewController
        }
        
        // If it's a child view controller, get the last one
        if let childViewController = viewController.children.last {
            return findTopmostViewController(from: childViewController)
        }
        
        // This is the topmost view controller
        return viewController
    }
}
