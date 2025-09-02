//
//  DiscoverDeepLink.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

// MARK: - Discover Deep Link
public struct DiscoverDeepLink: DeepLink {
    public let id: String
    public let path: String
    public let parameters: [String: String]
    public let filter: String?
    public let sort: String?
    
    public init?(from url: URL) {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let path = url.path.lowercased()
        let queryItems = components?.queryItems ?? []
        
        let parameters = Dictionary<String, String>(uniqueKeysWithValues: queryItems.compactMap { item in
            guard let value = item.value else { return nil }
            return (item.name, value)
        })
        
        let filter = parameters["filter"]
        let sort = parameters["sort"]
        
        self.id = UUID().uuidString
        self.path = path
        self.parameters = parameters
        self.filter = filter
        self.sort = sort
    }
    
    public init?(from path: String, parameters: [String: String]) {
        self.id = UUID().uuidString
        self.path = path
        self.parameters = parameters
        self.filter = parameters["filter"]
        self.sort = parameters["sort"]
    }
    
    public init(id: String, filter: String? = nil, sort: String? = nil, parameters: [String: String] = [:]) {
        self.id = id
        self.path = "discover"
        self.parameters = parameters
        self.filter = filter
        self.sort = sort
    }
    
    public func toURL() -> URL? {
        var components = URLComponents()
        components.scheme = "mstsvlbl"
        components.host = "discover"
        
        var queryItems: [URLQueryItem] = []
        if let filter = filter {
            queryItems.append(URLQueryItem(name: "filter", value: filter))
        }
        if let sort = sort {
            queryItems.append(URLQueryItem(name: "sort", value: sort))
        }
        queryItems += parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        components.queryItems = queryItems
        return components.url
    }
}
