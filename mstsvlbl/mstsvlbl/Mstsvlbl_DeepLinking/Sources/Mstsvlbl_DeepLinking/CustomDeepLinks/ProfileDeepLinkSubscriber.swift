//
//  ProfileDeepLinkSubscriber.swift
//  Mstsvlbl_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

@MainActor
public final class ProfileDeepLinkSubscriber<NavigationHandler>: NavigationOnlyDeepLinkSubscriber {
    public let id = "ProfileDeepLinkSubscriber"
    public let subscribedPath = "profile"
    
    public let navigationHandler: NavigationHandler
    
    public init(navigationHandler: NavigationHandler) async {
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
    }
}
