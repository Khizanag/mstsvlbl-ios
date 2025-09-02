//
//  ProfileDeepLinkSubscriber.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

@MainActor
public final class ProfileDeepLinkSubscriber: DeepLinkSubscriber {
    public let id = "ProfileDeepLinkSubscriber"
    public let subscribedPath = "profile"
    
    private let coordinator: Coordinator
    
    public init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    public func didReceiveDeepLink(_ deepLink: any DeepLink, context: DeepLinkContext) {
        guard let profileDeepLink = deepLink as? ProfileDeepLink else { return }
        
        print("🎯 ProfileDeepLinkSubscriber: Handling profile deep link with ID: \(profileDeepLink.id), action: \(profileDeepLink.action)")
        
        switch profileDeepLink.action {
        case "view":
            navigateToProfile()
        case "edit":
            navigateToProfileEdit()
        case "settings":
            navigateToProfileSettings()
        default:
            navigateToProfile()
        }
    }
    
    private func navigateToProfile() {
        // For now, just navigate to the list since we don't have profile pages yet
        // You can extend the Page enum later to add more cases
        coordinator.push(.list)
    }
    
    private func navigateToProfileEdit() {
        // For now, just navigate to the list since we don't have profile pages yet
        coordinator.push(.list)
    }
    
    private func navigateToProfileSettings() {
        // For now, just navigate to the list since we don't have profile pages yet
        coordinator.push(.list)
    }
}
