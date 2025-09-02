//
//  StatsDeepLink.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

// MARK: - Stats Deep Link
public struct StatsDeepLink: DeepLink {
    public let id: String
    public let path: String
    public let parameters: [String: String]
    public let period: String
    
    public init?(from url: URL) {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let path = url.path.lowercased()
        let queryItems = components?.queryItems ?? []
        
        let parameters = Dictionary<String, String>(uniqueKeysWithValues: queryItems.compactMap { item in
            guard let value = item.value else { return nil }
            return (item.name, value)
        })
        
        let period = parameters["period"] ?? "all"
        
        self.id = UUID().uuidString
        self.path = path
        self.parameters = parameters
        self.period = period
    }
    
    public init?(from path: String, parameters: [String: String]) {
        self.id = UUID().uuidString
        self.path = path
        self.parameters = parameters
        self.period = parameters["period"] ?? "all"
    }
    
    public init(id: String, period: String, parameters: [String: String] = [:]) {
        self.id = id
        self.path = "stats"
        self.parameters = parameters
        self.period = period
    }
    
    public func toURL() -> URL? {
        var components = URLComponents()
        components.scheme = "mstsvlbl"
        components.host = "stats"
        components.queryItems = [
            URLQueryItem(name: "period", value: period)
        ] + parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        return components.url
    }
}
