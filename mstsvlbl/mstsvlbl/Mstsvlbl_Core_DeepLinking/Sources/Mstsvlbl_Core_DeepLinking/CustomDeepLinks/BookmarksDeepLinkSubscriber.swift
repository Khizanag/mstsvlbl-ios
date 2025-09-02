//
//  BookmarksDeepLinkSubscriber.swift
//  Mstsvlbl_Core_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import UIKit

@MainActor
public final class BookmarksDeepLinkSubscriber: DeepLinkSubscriber {
    public let id = "BookmarksDeepLinkSubscriber"
    public let subscribedPath = "bookmarks"
    
    public let navigationHandler: UIWindow
    
    public init(navigationHandler: UIWindow) async {
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
        
        // Example of how to add content directly over the window
        print("🎯 BookmarksDeepLinkSubscriber: Opening bookmarks")
        // Here you can add a view controller or view directly to the window
        // For example: navigationHandler.addSubview(someView)
    }
}
