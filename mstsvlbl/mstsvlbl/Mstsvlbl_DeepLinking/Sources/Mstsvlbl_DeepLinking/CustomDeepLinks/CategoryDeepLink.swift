//
//  CategoryDeepLink.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

// MARK: - Category Deep Link
public struct CategoryDeepLink: DeepLink {
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
        
        let categoryName = parameters["name"] ?? UUID().uuidString
        
        self.id = categoryName
        self.path = path
        self.parameters = parameters
    }
    
    public init?(from path: String, parameters: [String: String]) {
        self.id = parameters["name"] ?? UUID().uuidString
        self.path = path
        self.parameters = parameters
    }
    
    public init(id: String, parameters: [String: String] = [:]) {
        self.id = id
        self.path = "category"
        self.parameters = parameters
    }
    
    public func toURL() -> URL? {
        var components = URLComponents()
        components.scheme = "mstsvlbl"
        components.host = "category"
        components.queryItems = [
            URLQueryItem(name: "name", value: id)
        ] + parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        return components.url
    }
}
