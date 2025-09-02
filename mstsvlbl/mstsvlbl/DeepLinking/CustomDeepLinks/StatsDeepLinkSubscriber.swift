//
//  StatsDeepLinkSubscriber.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

@MainActor
public final class StatsDeepLinkSubscriber: DeepLinkSubscriber {
    public let id = "StatsDeepLinkSubscriber"
    public let subscribedPath = "stats"
    
    private let coordinator: Coordinator
    
    public init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    public func didReceiveDeepLink(_ deepLink: any DeepLink, context: DeepLinkContext) {
        guard let statsDeepLink = deepLink as? StatsDeepLink else { return }
        
        print("🎯 StatsDeepLinkSubscriber: Handling stats deep link with ID: \(statsDeepLink.id), period: \(statsDeepLink.period)")
        
        navigateToStats(period: statsDeepLink.period)
    }
    
    private func navigateToStats(period: String) {
        // For now, just navigate to the list since we don't have stats pages yet
        // You can extend the Page enum later to add more cases
        coordinator.push(.list)
    }
}
