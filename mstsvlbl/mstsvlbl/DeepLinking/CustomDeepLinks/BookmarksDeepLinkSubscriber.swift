//
//  BookmarksDeepLinkSubscriber.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

@MainActor
public final class BookmarksDeepLinkSubscriber: DeepLinkSubscriber {
    public let id = "BookmarksDeepLinkSubscriber"
    public let subscribedPath = "bookmarks"
    
    private let coordinator: Coordinator
    
    public init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    public func didReceiveDeepLink(_ deepLink: any DeepLink, context: DeepLinkContext) {
        guard let bookmarksDeepLink = deepLink as? BookmarksDeepLink else { return }
        
        print("🎯 BookmarksDeepLinkSubscriber: Handling bookmarks deep link with ID: \(bookmarksDeepLink.id), filter: \(bookmarksDeepLink.filter ?? "none")")
        
        navigateToBookmarks(filter: bookmarksDeepLink.filter)
    }
    
    private func navigateToBookmarks(filter: String?) {
        // For now, just navigate to the list since we don't have bookmarks pages yet
        // You can extend the Page enum later to add more cases
        coordinator.push(.list)
    }
}
