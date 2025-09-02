//
//  StatsDeepLinkRoute.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

public final class StatsDeepLinkRoute: DeepLinkRoute {
    public init() {}
    
    public func route(_ deepLink: any DeepLink) -> DeepLinkDestination? {
        guard let statsDeepLink = deepLink as? StatsDeepLink else {
            return nil
        }
        
        return .stats(period: statsDeepLink.period)
    }
}
