//
//  DiscoverDeepLinkRoute.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

// MARK: - Discover Deep Link Route
public final class DiscoverDeepLinkRoute: DeepLinkRoute {
    public init() {}
    
    public func route(_ deepLink: any DeepLink) -> DeepLinkDestination? {
        guard let discoverDeepLink = deepLink as? DiscoverDeepLink else {
            return nil
        }
        
        return .discover(filter: discoverDeepLink.filter, sort: discoverDeepLink.sort)
    }
}
