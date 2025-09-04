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
        guard url.scheme?.lowercased() == scheme.lowercased() else {
            return nil
        }
        
        guard let host = url.host?.lowercased() else {
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
        
        return DeepLink(name: host, parameters: parameters)
    }
}
