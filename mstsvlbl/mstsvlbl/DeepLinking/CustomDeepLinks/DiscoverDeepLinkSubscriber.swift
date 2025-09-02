//
//  DiscoverDeepLinkSubscriber.swift
//  Mstsvlbl_Core_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import UIKit
import Mstsvlbl_Core_DeepLinking

@MainActor
public final class DiscoverDeepLinkSubscriber: DeepLinkSubscriber {
    public let id = "DiscoverDeepLinkSubscriber"
    public let subscribedPath = "discover"
    
    public let navigationHandler: UIWindow
    
    public init(navigationHandler: UIWindow) async {
        self.navigationHandler = navigationHandler
    }
    
    public func didReceiveDeepLink(_ deepLink: any DeepLink, context: DeepLinkContext) async {
        print("🎯 DiscoverDeepLinkSubscriber: Handling discover deep link")
        
        await handleDiscoverDeepLink(deepLink)
    }
    
    private func handleDiscoverDeepLink(_ deepLink: any DeepLink) async {
        print("🎯 DiscoverDeepLinkSubscriber: Processing discover deep link with path: \(deepLink.path)")
        print("🎯 DiscoverDeepLinkSubscriber: Parameters: \(deepLink.parameters)")
        print("🎯 DiscoverDeepLinkSubscriber: Navigation handler: \(type(of: navigationHandler))")
        
        // Example of how to add content directly over the window
        print("🎯 DiscoverDeepLinkSubscriber: Opening discover")
        // Here you can add a view controller or view directly to the window
        // For example: navigationHandler.addSubview(someView)
    }
}
