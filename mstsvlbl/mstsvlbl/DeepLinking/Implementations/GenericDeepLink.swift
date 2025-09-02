//
//  GenericDeepLink.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

// MARK: - Generic Deep Link
public struct GenericDeepLink: DeepLink {
    public let id: String
    public let path: String
    public let parameters: [String: String]
    
    public init?(from url: URL) {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let path = url.path.lowercased()
        let queryItems = components?.queryItems ?? []
        
        let parameters = Dictionary<String, String>(uniqueKeysWithValues: queryItems.compactMap { item in
            guard let value = item.value else { return nil }
            return (item.name, value)
        })
        
        self.id = UUID().uuidString
        self.path = path
        self.parameters = parameters
    }
    
    public init?(from path: String, parameters: [String: String]) {
        self.id = UUID().uuidString
        self.path = path
        self.parameters = parameters
    }
    
    public init(id: String, path: String, parameters: [String: String] = [:]) {
        self.id = id
        self.path = path
        self.parameters = parameters
    }
    
    public func toURL() -> URL? {
        var components = URLComponents()
        components.scheme = "mstsvlbl"
        components.host = path
        components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        return components.url
    }
}
