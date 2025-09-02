//
//  UniversalLinkParser.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

// MARK: - Universal Link Parser
public final class UniversalLinkParser: DeepLinkURLParser {
    private let supportedDomains = ["mstsvlbl.com", "www.mstsvlbl.com"]
    
    public init() {}
    
    public func parse(_ url: URL) -> (any DeepLink)? {
        guard let host = url.host?.lowercased(),
              supportedDomains.contains(host) else {
            return nil
        }
        
        let path = url.path.lowercased()
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []
        
        let parameters = Dictionary<String, String>(uniqueKeysWithValues: queryItems.compactMap { item in
            guard let value = item.value else { return nil }
            return (item.name, value)
        })
        
        // Parse based on path
        switch path {
        case "/quiz":
            return QuizDeepLink(from: path, parameters: parameters)
        case "/category":
            return CategoryDeepLink(from: path, parameters: parameters)
        case "/profile":
            return ProfileDeepLink(from: path, parameters: parameters)
        case "/settings":
            return SettingsDeepLink(from: path, parameters: parameters)
        case "/discover":
            return DiscoverDeepLink(from: path, parameters: parameters)
        case "/bookmarks":
            return BookmarksDeepLink(from: path, parameters: parameters)
        case "/stats":
            return StatsDeepLink(from: path, parameters: parameters)
        default:
            return CustomDeepLink(from: path, parameters: parameters)
        }
    }
    
    public func getSupportedPaths() -> [String] {
        ["/quiz", "/category", "/profile", "/settings", "/discover", "/bookmarks", "/stats"]
    }
}
