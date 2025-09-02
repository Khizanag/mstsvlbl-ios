//
//  UniversalLinkParser.swift
//  Mstsvlbl_Core_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

public final class UniversalLinkParser: DeepLinkURLParser {
    public init() {}
    
    public func parse(_ url: URL) -> (any DeepLink)? {
        let pathComponents = url.pathComponents.filter { $0 != "/" }
        guard let firstPath = pathComponents.first else {
            return nil
        }
        
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []
        
        let parameters = Dictionary<String, String>(
            uniqueKeysWithValues: queryItems.compactMap { item in
                guard let value = item.value else { return nil }
                return (item.name, value)
            }
        )
        
        // Create a generic deep link where the first path component becomes the path
        // Note: This parser cannot create concrete deep link instances
        // Applications should implement their own parsing logic
        return nil
    }
    
    public func getSupportedPaths() -> [String] {
        // Return empty array since we support any path dynamically
        []
    }
}
