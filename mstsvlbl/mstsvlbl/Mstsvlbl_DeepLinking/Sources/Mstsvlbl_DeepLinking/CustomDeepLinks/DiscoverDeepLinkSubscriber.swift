//
//  DiscoverDeepLinkSubscriber.swift
//  Mstsvlbl_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

@MainActor
public final class DiscoverDeepLinkSubscriber<NavigationHandler>: NavigationOnlyDeepLinkSubscriber {
    public let id = "DiscoverDeepLinkSubscriber"
    public let subscribedPath = "discover"
    
    public let navigationHandler: NavigationHandler
    
    public init(navigationHandler: NavigationHandler) async {
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
    }
}
