//
//  SettingsDeepLinkSubscriber.swift
//  Mstsvlbl_Core_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import UIKit
import Mstsvlbl_Core_DeepLinking

@MainActor
public final class SettingsDeepLinkSubscriber: DeepLinkSubscriber {
    public let id = "SettingsDeepLinkSubscriber"
    public let subscribedPath = "settings"
    
    public let navigationHandler: UIWindow
    
    public init(navigationHandler: UIWindow) async {
        self.navigationHandler = navigationHandler
    }
    
    public func didReceiveDeepLink(_ deepLink: any DeepLink, context: DeepLinkContext) async {
        print("🎯 SettingsDeepLinkSubscriber: Handling settings deep link")
        
        await handleSettingsDeepLink(deepLink)
    }
    
    private func handleSettingsDeepLink(_ deepLink: any DeepLink) async {
        print("🎯 SettingsDeepLinkSubscriber: Processing settings deep link with path: \(deepLink.path)")
        print("🎯 SettingsDeepLinkSubscriber: Parameters: \(deepLink.parameters)")
        print("🎯 SettingsDeepLinkSubscriber: Navigation handler: \(type(of: navigationHandler))")
        
        // Example of how to add content directly over the window
        print("🎯 SettingsDeepLinkSubscriber: Opening settings")
        // Here you can add a view controller or view directly to the window
        // For example: navigationHandler.addSubview(someView)
    }
}
