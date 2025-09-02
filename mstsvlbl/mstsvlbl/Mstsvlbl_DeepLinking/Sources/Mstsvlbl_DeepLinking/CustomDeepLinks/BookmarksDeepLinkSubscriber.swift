//
//  BookmarksDeepLinkSubscriber.swift
//  Mstsvlbl_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

@MainActor
public final class BookmarksDeepLinkSubscriber<NavigationHandler>: NavigationOnlyDeepLinkSubscriber {
    public let id = "BookmarksDeepLinkSubscriber"
    public let subscribedPath = "bookmarks"
    
    public let navigationHandler: NavigationHandler
    
    public init(navigationHandler: NavigationHandler) async {
        self.navigationHandler = navigationHandler
    }
    
    public func didReceiveDeepLink(_ deepLink: any DeepLink, context: DeepLinkContext) async {
        print("🎯 BookmarksDeepLinkSubscriber: Handling bookmarks deep link")
        
        await handleBookmarksDeepLink(deepLink)
    }
    
    private func handleBookmarksDeepLink(_ deepLink: any DeepLink) async {
        print("🎯 BookmarksDeepLinkSubscriber: Processing bookmarks deep link with path: \(deepLink.path)")
        print("🎯 BookmarksDeepLinkSubscriber: Parameters: \(deepLink.parameters)")
        print("🎯 BookmarksDeepLinkSubscriber: Navigation handler: \(type(of: navigationHandler))")
    }
}
