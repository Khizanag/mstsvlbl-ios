//
//  CategoryDeepLinkSubscriber.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

@MainActor
public final class CategoryDeepLinkSubscriber: DeepLinkSubscriber {
    public let id = "CategoryDeepLinkSubscriber"
    public let subscribedPath = "category"
    
    private let coordinator: Coordinator
    
    public init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    public func didReceiveDeepLink(_ deepLink: any DeepLink, context: DeepLinkContext) {
        guard let categoryDeepLink = deepLink as? CategoryDeepLink else { return }
        
        print("🎯 CategoryDeepLinkSubscriber: Handling category deep link with ID: \(categoryDeepLink.id)")
        
        navigateToCategory(categoryDeepLink.id)
    }
    
    private func navigateToCategory(_ categoryName: String) {
        // For now, just navigate to the list since we don't have a specific category page
        // You can extend the Page enum later to add more cases
        coordinator.push(.list)
    }
}
