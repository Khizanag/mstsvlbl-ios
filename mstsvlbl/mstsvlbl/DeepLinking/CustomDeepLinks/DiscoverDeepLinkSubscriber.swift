//
//  DiscoverDeepLinkSubscriber.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

@MainActor
public final class DiscoverDeepLinkSubscriber: DeepLinkSubscriber {
    public let id = "DiscoverDeepLinkSubscriber"
    public let subscribedPath = "discover"
    
    private let coordinator: Coordinator
    
    public init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    public func didReceiveDeepLink(_ deepLink: any DeepLink, context: DeepLinkContext) {
        guard let discoverDeepLink = deepLink as? DiscoverDeepLink else { return }
        
        print("🎯 DiscoverDeepLinkSubscriber: Handling discover deep link with ID: \(discoverDeepLink.id), filter: \(discoverDeepLink.filter ?? "none"), sort: \(discoverDeepLink.sort ?? "none")")
        
        navigateToDiscover(filter: discoverDeepLink.filter, sort: discoverDeepLink.sort)
    }
    
    private func navigateToDiscover(filter: String?, sort: String?) {
        // For now, just navigate to the list since we don't have discover pages yet
        // You can extend the Page enum later to add more cases
        coordinator.push(.list)
    }
}
