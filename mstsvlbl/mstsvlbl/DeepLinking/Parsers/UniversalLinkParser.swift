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
        
        return switch path {
        case "/quiz":
            QuizDeepLink(from: path, parameters: parameters)
        case "/category":
            CategoryDeepLink(from: path, parameters: parameters)
        case "/profile":
            ProfileDeepLink(from: path, parameters: parameters)
        case "/settings":
            SettingsDeepLink(from: path, parameters: parameters)
        case "/discover":
            DiscoverDeepLink(from: path, parameters: parameters)
        case "/bookmarks":
            BookmarksDeepLink(from: path, parameters: parameters)
        case "/stats":
            StatsDeepLink(from: path, parameters: parameters)
        default:
            CustomDeepLink(from: path, parameters: parameters)
        }
    }
    
    public func getSupportedPaths() -> [String] {
        ["/quiz", "/category", "/profile", "/settings", "/discover", "/bookmarks", "/stats"]
    }
}
