//
//  ProfileDeepLinkSubscriber.swift
//  Mstsvlbl_Core_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import UIKit

@MainActor
public final class ProfileDeepLinkSubscriber: DeepLinkSubscriber {
    public let id = "ProfileDeepLinkSubscriber"
    public let subscribedPath = "profile"
    
    public let navigationHandler: UIWindow
    
    public init(navigationHandler: UIWindow) async {
        self.navigationHandler = navigationHandler
    }
    
    public func didReceiveDeepLink(_ deepLink: any DeepLink, context: DeepLinkContext) async {
        print("🎯 ProfileDeepLinkSubscriber: Handling profile deep link")
        
        await handleProfileDeepLink(deepLink)
    }
    
    private func handleProfileDeepLink(_ deepLink: any DeepLink) async {
        print("🎯 ProfileDeepLinkSubscriber: Processing profile deep link with path: \(deepLink.path)")
        print("🎯 ProfileDeepLinkSubscriber: Parameters: \(deepLink.parameters)")
        print("🎯 ProfileDeepLinkSubscriber: Navigation handler: \(type(of: navigationHandler))")
        
        // Example of how to add content directly over the window
        print("🎯 ProfileDeepLinkSubscriber: Opening profile")
        // Here you can add a view controller or view directly to the window
        // For example: navigationHandler.addSubview(someView)
    }
}
