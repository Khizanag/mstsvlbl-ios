//
//  SettingsDeepLink.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

public struct SettingsDeepLink: DeepLink {
    public let id: String
    public let path: String
    public let parameters: [String: String]
    public let section: String
    
    public init?(from url: URL) {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let path = url.path.lowercased()
        let queryItems = components?.queryItems ?? []
        
        let parameters = Dictionary<String, String>(uniqueKeysWithValues: queryItems.compactMap { item in
            guard let value = item.value else { return nil }
            return (item.name, value)
        })
        
        let section = parameters["section"] ?? "general"
        
        self.id = UUID().uuidString
        self.path = path
        self.parameters = parameters
        self.section = section
    }
    
    public init?(from path: String, parameters: [String: String]) {
        self.id = UUID().uuidString
        self.path = path
        self.parameters = parameters
        self.section = parameters["section"] ?? "general"
    }
    
    public init(id: String, section: String, parameters: [String: String] = [:]) {
        self.id = id
        self.path = "settings"
        self.parameters = parameters
        self.section = section
    }
    
    public func toURL() -> URL? {
        var components = URLComponents()
        components.scheme = "mstsvlbl"
        components.host = "settings"
        components.queryItems = [
            URLQueryItem(name: "section", value: section)
        ] + parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        return components.url
    }
}
