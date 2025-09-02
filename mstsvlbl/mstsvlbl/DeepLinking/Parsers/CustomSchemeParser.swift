//
//  CustomSchemeParser.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

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
        
        return switch host {
        case "quiz":
            QuizDeepLink(from: host, parameters: parameters)
        case "category":
            CategoryDeepLink(from: host, parameters: parameters)
        case "profile":
            ProfileDeepLink(from: host, parameters: parameters)
        case "settings":
            SettingsDeepLink(from: host, parameters: parameters)
        case "discover":
            DiscoverDeepLink(from: host, parameters: parameters)
        case "bookmarks":
            BookmarksDeepLink(from: host, parameters: parameters)
        case "stats":
            StatsDeepLink(from: host, parameters: parameters)
        default:
            CustomDeepLink(from: host, parameters: parameters)
        }
    }
    
    public func getSupportedPaths() -> [String] {
        ["quiz", "category", "profile", "settings", "discover", "bookmarks", "stats"]
    }
}
