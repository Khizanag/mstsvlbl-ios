//
//  CategoryDeepLinkSubscriber.swift
//  Mstsvlbl_Core_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import UIKit
import Mstsvlbl_Core_DeepLinking

@MainActor
public final class CategoryDeepLinkSubscriber: DeepLinkSubscriber {
    public let id = "CategoryDeepLinkSubscriber"
    public let subscribedPath = "category"
    
    public let navigationHandler: UIWindow
    
    public init(navigationHandler: UIWindow) async {
        self.navigationHandler = navigationHandler
    }
    
    public func didReceiveDeepLink(_ deepLink: any DeepLink, context: DeepLinkContext) async {
        print("🎯 CategoryDeepLinkSubscriber: Handling category deep link")
        
        await handleCategoryDeepLink(deepLink)
    }
    
    private func handleCategoryDeepLink(_ deepLink: any DeepLink) async {
        print("🎯 CategoryDeepLinkSubscriber: Processing category deep link with path: \(deepLink.path)")
        print("🎯 CategoryDeepLinkSubscriber: Parameters: \(deepLink.parameters)")
        print("🎯 CategoryDeepLinkSubscriber: Navigation handler: \(type(of: navigationHandler))")
        
        // Example of how to add content directly over the window
        if let categoryId = deepLink.parameters["id"] {
            print("🎯 CategoryDeepLinkSubscriber: Opening category with ID: \(categoryId)")
            // Here you can add a view controller or view directly to the window
            // For example: navigationHandler.addSubview(someView)
        }
    }
}
