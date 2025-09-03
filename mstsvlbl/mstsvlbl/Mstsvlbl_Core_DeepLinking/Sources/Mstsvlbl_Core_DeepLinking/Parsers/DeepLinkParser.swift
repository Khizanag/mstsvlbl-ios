//
//  DeepLinkParser.swift
//  Mstsvlbl_Core_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

public protocol DeepLinkURLParser {
    func parse(_ url: URL) -> DeepLink?
}

public final class DeepLinkParser {
    private var parsers: [String: DeepLinkURLParser] = [:]
    
    public init() {
        setupDefaultParsers()
    }
    
    private func setupDefaultParsers() {
        // Register custom scheme parser with the app's scheme
        let customSchemeParser = CustomSchemeParser(scheme: "mstsvlbl")
        parsers["custom"] = customSchemeParser
        
        // Register universal link parser
        let universalLinkParser = UniversalLinkParser()
        parsers["universal"] = universalLinkParser
    }
    
    public func parse(_ url: URL) -> DeepLink? {
        if let universalLinkParser = parsers["universal"],
           let deepLink = universalLinkParser.parse(url)
        {
            return deepLink
        }
        
        if let customSchemeParser = parsers["custom"],
           let deepLink = customSchemeParser.parse(url)
        {
            return deepLink
        }
        
        
        return nil
    }
    
    public func registerParser(_ parser: DeepLinkURLParser, for key: String) {
        parsers[key] = parser
    }
}
