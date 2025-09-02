//
//  CustomSchemeParser.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

// MARK: - Custom Scheme Parser
public final class CustomSchemeParser: DeepLinkURLParser {
    public init() {}
    
    public func parse(_ url: URL) -> (any DeepLink)? {
        guard let host = url.host?.lowercased() else {
            return nil
        }
        
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []
        
        let parameters = Dictionary<String, String>(uniqueKeysWithValues: queryItems.compactMap { item in
            guard let value = item.value else { return nil }
            return (item.name, value)
        })
        
        // Parse based on host
        switch host {
        case "quiz":
            return QuizDeepLink(from: host, parameters: parameters)
        case "category":
            return CategoryDeepLink(from: host, parameters: parameters)
        case "profile":
            return ProfileDeepLink(from: host, parameters: parameters)
        case "settings":
            return SettingsDeepLink(from: host, parameters: parameters)
        case "discover":
            return DiscoverDeepLink(from: host, parameters: parameters)
        case "bookmarks":
            return BookmarksDeepLink(from: host, parameters: parameters)
        case "stats":
            return StatsDeepLink(from: host, parameters: parameters)
        default:
            return CustomDeepLink(from: host, parameters: parameters)
        }
    }
    
    public func getSupportedPaths() -> [String] {
        ["quiz", "category", "profile", "settings", "discover", "bookmarks", "stats"]
    }
}
