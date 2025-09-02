//
//  SettingsDeepLinkSubscriber.swift
//  Mstsvlbl_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

@MainActor
public final class SettingsDeepLinkSubscriber<NavigationHandler>: NavigationOnlyDeepLinkSubscriber {
    public let id = "SettingsDeepLinkSubscriber"
    public let subscribedPath = "settings"
    
    public let navigationHandler: NavigationHandler
    
    public init(navigationHandler: NavigationHandler) async {
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
    }
}
