//
//  BookmarksDeepLink.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

public struct BookmarksDeepLink: DeepLink {
    public let id: String
    public let path: String
    public let parameters: [String: String]
    public let filter: String?
    
    public init?(from url: URL) {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let path = url.path.lowercased()
        let queryItems = components?.queryItems ?? []
        
        let parameters = Dictionary<String, String>(uniqueKeysWithValues: queryItems.compactMap { item in
            guard let value = item.value else { return nil }
            return (item.name, value)
        })
        
        let filter = parameters["filter"]
        
        self.id = UUID().uuidString
        self.path = path
        self.parameters = parameters
        self.filter = filter
    }
    
    public init?(from path: String, parameters: [String: String]) {
        self.id = UUID().uuidString
        self.path = path
        self.parameters = parameters
        self.filter = parameters["filter"]
    }
    
    public init(id: String, filter: String? = nil, parameters: [String: String] = [:]) {
        self.id = id
        self.path = "bookmarks"
        self.parameters = parameters
        self.filter = filter
    }
    
    public func toURL() -> URL? {
        var components = URLComponents()
        components.scheme = "mstsvlbl"
        components.host = "bookmarks"
        
        var queryItems: [URLQueryItem] = []
        if let filter = filter {
            queryItems.append(URLQueryItem(name: "filter", value: filter))
        }
        queryItems += parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        components.queryItems = queryItems
        return components.url
    }
}
