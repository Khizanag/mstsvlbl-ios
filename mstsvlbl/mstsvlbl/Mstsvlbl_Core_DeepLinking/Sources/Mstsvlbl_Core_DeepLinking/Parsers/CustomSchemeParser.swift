//
//  CustomSchemeParser.swift
//  Mstsvlbl_Core_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

public final class CustomSchemeParser: DeepLinkURLParser {
    private let scheme: String
    
    public init(scheme: String) {
        self.scheme = scheme
    }
    
    public func parse(_ url: URL) -> DeepLink? {
        // Verify the URL scheme matches our expected scheme
        guard url.scheme?.lowercased() == scheme.lowercased() else {
            print("🔗 CustomSchemeParser: URL scheme '\(url.scheme ?? "nil")' doesn't match expected scheme '\(scheme)'")
            return nil
        }
        
        // Extract the host as the name (e.g., "quiz" from "mstsvlbl://quiz?id=123")
        guard let host = url.host?.lowercased() else {
            print("🔗 CustomSchemeParser: No host found in URL: \(url)")
            return nil
        }
        
        // Parse query parameters
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []
        
        let parameters = Dictionary<String, String>(
            uniqueKeysWithValues: queryItems.compactMap { item in
                guard let value = item.value else { return nil }
                return (item.name, value)
            }
        )
        
        // Create and return the deep link
        return DeepLink(name: host, parameters: parameters)
    }
}
