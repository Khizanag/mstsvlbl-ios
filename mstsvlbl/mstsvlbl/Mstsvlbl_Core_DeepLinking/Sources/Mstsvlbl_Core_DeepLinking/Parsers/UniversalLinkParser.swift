//
//  UniversalLinkParser.swift
//  Mstsvlbl_Core_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

public final class UniversalLinkParser: DeepLinkURLParser {
    public init() {}
    
    public func parse(_ url: URL) -> DeepLink? {
        let pathComponents = url.pathComponents.filter { $0 != "/" }
        guard let firstPath = pathComponents.first else {
            print("🔗 UniversalLinkParser: No path components found in URL: \(url)")
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
        
        print("🔗 UniversalLinkParser: Parsed URL - Name: \(firstPath), Parameters: \(parameters)")
        
        // Create and return the deep link
        return DeepLink(name: firstPath, parameters: parameters)
    }
}
