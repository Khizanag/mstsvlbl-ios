//
//  SettingsDeepLinkRoute.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

// MARK: - Settings Deep Link Route
public final class SettingsDeepLinkRoute: DeepLinkRoute {
    public init() {}
    
    public func route(_ deepLink: any DeepLink) -> DeepLinkDestination? {
        guard let settingsDeepLink = deepLink as? SettingsDeepLink else {
            return nil
        }
        
        return .settings(section: settingsDeepLink.section)
    }
}
