//
//  StatsDeepLinkSubscriber.swift
//  Mstsvlbl_Core_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import UIKit
import Mstsvlbl_Core_DeepLinking

@MainActor
public final class StatsDeepLinkSubscriber: DeepLinkSubscriber {
    public let id = "StatsDeepLinkSubscriber"
    public let subscribedPath = "stats"
    
    public let navigationHandler: UIWindow
    
    public init(navigationHandler: UIWindow) async {
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
        
        // Example of how to add content directly over the window
        print("🎯 StatsDeepLinkSubscriber: Opening stats")
        // Here you can add a view controller or view directly to the window
        // For example: navigationHandler.addSubview(someView)
    }
}
