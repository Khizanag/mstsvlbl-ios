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
        
        // Create and return the deep link
        return DeepLink(name: firstPath, parameters: parameters)
    }
}
