//
//  SettingsDeepLinkSubscriber.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

@MainActor
public final class SettingsDeepLinkSubscriber: DeepLinkSubscriber {
    public let id = "SettingsDeepLinkSubscriber"
    public let subscribedPath = "settings"
    
    private let coordinator: Coordinator
    
    public init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    public func didReceiveDeepLink(_ deepLink: any DeepLink, context: DeepLinkContext) {
        guard let settingsDeepLink = deepLink as? SettingsDeepLink else { return }
        
        print("🎯 SettingsDeepLinkSubscriber: Handling settings deep link with ID: \(settingsDeepLink.id), section: \(settingsDeepLink.section)")
        
        navigateToSettingsSection(settingsDeepLink.section)
    }
    
    private func navigateToSettingsSection(_ section: String) {
        // For now, just navigate to the list since we don't have settings pages yet
        // You can extend the Page enum later to add more cases
        coordinator.push(.list)
    }
}
