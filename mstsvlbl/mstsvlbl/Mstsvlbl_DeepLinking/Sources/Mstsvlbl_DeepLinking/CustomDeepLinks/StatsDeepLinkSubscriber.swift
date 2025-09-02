//
//  StatsDeepLinkSubscriber.swift
//  Mstsvlbl_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

@MainActor
public final class StatsDeepLinkSubscriber<NavigationHandler>: NavigationOnlyDeepLinkSubscriber {
    public let id = "StatsDeepLinkSubscriber"
    public let subscribedPath = "stats"
    
    public let navigationHandler: NavigationHandler
    
    public init(navigationHandler: NavigationHandler) async {
        self.navigationHandler = navigationHandler
    }
    
    public func didReceiveDeepLink(_ deepLink: any DeepLink, context: DeepLinkContext) async {
        print("🎯 StatsDeepLinkSubscriber: Handling stats deep link")
        
        await handleStatsDeepLink(deepLink)
    }
    
    private func handleStatsDeepLink(_ deepLink: any DeepLink) async {
        print("🎯 StatsDeepLinkSubscriber: Processing stats deep link with path: \(deepLink.path)")
        print("🎯 StatsDeepLinkSubscriber: Parameters: \(deepLink.parameters)")
        print("🎯 StatsDeepLinkSubscriber: Navigation handler: \(type(of: navigationHandler))")
    }
}
