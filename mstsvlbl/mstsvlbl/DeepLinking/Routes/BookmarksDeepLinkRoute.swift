//
//  BookmarksDeepLinkRoute.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

public final class BookmarksDeepLinkRoute: DeepLinkRoute {
    public init() {}
    
    public func route(_ deepLink: any DeepLink) -> DeepLinkDestination? {
        guard let bookmarksDeepLink = deepLink as? BookmarksDeepLink else {
            return nil
        }
        
        return .bookmarks(filter: bookmarksDeepLink.filter)
    }
}
