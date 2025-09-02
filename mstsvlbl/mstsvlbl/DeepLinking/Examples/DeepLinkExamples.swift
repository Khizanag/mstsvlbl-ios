//
//  DeepLinkExamples.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

// MARK: - DeepLink Examples
public struct DeepLinkExamples {
    
    // MARK: - Example URLs
    public static let exampleURLs = [
        "mstsvlbl://quiz?id=math_quiz&action=play",
        "mstsvlbl://category?name=science",
        "mstsvlbl://profile?action=edit",
        "mstsvlbl://settings?section=notifications",
        "mstsvlbl://discover?filter=popular&sort=rating",
        "mstsvlbl://bookmarks?filter=favorites",
        "mstsvlbl://stats?period=monthly"
    ]
    
    // MARK: - Example Deep Links
    public static let exampleDeepLinks: [any DeepLink] = [
        QuizDeepLink(id: "math_quiz", action: "play"),
        CategoryDeepLink(id: "science"),
        ProfileDeepLink(id: "user123", action: "edit"),
        SettingsDeepLink(id: "settings", section: "notifications"),
        DiscoverDeepLink(id: "discover", filter: "popular", sort: "rating"),
        BookmarksDeepLink(id: "bookmarks", filter: "favorites"),
        StatsDeepLink(id: "stats", period: "monthly")
    ]
    
    // MARK: - Example Contexts
    public static let exampleContexts = [
        DeepLinkContext(source: .appLaunch),
        DeepLinkContext(source: .universalLink),
        DeepLinkContext(source: .customScheme),
        DeepLinkContext(source: .pushNotification),
        DeepLinkContext(source: .background),
        DeepLinkContext(source: .foreground)
    ]
}

// MARK: - Example Deep Link Subscriber
public final class ExampleDeepLinkSubscriber: DeepLinkSubscriber {
    public let id: String
    public let name: String
    
    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    public func didReceiveDeepLink(_ deepLink: any DeepLink, context: DeepLinkContext) {
        print("📱 [\(name)] Received deep link: \(deepLink.path) with ID: \(deepLink.id)")
        print("📱 [\(name)] Source: \(context.source.displayName)")
        print("📱 [\(name)] Timestamp: \(context.timestamp)")
    }
    
    public func canHandleDeepLink(_ deepLink: any DeepLink) -> Bool {
        // This example subscriber can handle all deep links
        true
    }
}

// MARK: - DeepLink Manager Extensions for Testing
public extension DeepLinkManager {
    
    /// Test method to simulate deep link processing
    func testDeepLink(_ urlString: String) async -> DeepLinkResult {
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }
        return await process(url, source: .customScheme)
    }
    
    /// Test method to get all registered handlers
    func testGetAllHandlers() -> [any DeepLinkHandler] {
        getAllHandlers()
    }
    
    /// Test method to get all registered routes
    func testGetAllRoutes() -> [String] {
        getRegisteredRoutes()
    }
}

// MARK: - DeepLink Builder
public struct DeepLinkBuilder {
    
    public static func quiz(id: String, action: String = "view") -> URL? {
        QuizDeepLink(id: id, action: action).toURL()
    }
    
    public static func category(name: String) -> URL? {
        CategoryDeepLink(id: name).toURL()
    }
    
    public static func profile(action: String) -> URL? {
        ProfileDeepLink(id: "profile", action: action).toURL()
    }
    
    public static func settings(section: String) -> URL? {
        SettingsDeepLink(id: "settings", section: section).toURL()
    }
    
    public static func discover(filter: String? = nil, sort: String? = nil) -> URL? {
        DiscoverDeepLink(id: "discover", filter: filter, sort: sort).toURL()
    }
    
    public static func bookmarks(filter: String? = nil) -> URL? {
        BookmarksDeepLink(id: "bookmarks", filter: filter).toURL()
    }
    
    public static func stats(period: String) -> URL? {
        StatsDeepLink(id: "stats", period: period).toURL()
    }
}
