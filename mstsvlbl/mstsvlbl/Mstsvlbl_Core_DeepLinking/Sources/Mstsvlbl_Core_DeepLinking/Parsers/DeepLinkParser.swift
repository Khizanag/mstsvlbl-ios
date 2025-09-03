//
//  DeepLinkParser.swift
//  Mstsvlbl_Core_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

public protocol DeepLinkURLParser {
    func parse(_ url: URL) -> (any DeepLink)?
    func getSupportedPaths() -> [String]
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
    
    public func parse(_ url: URL) -> (any DeepLink)? {
        // Try custom scheme first (e.g., mstsvlbl://quiz?id=123)
        if let customSchemeParser = parsers["custom"],
           let deepLink = customSchemeParser.parse(url) {
            print("🔗 DeepLinkParser: Successfully parsed custom scheme URL")
            return deepLink
        }
        
        // Try universal link (e.g., https://mstsvlbl.com/quiz?id=123)
        if let universalLinkParser = parsers["universal"],
           let deepLink = universalLinkParser.parse(url) {
            print("🔗 DeepLinkParser: Successfully parsed universal link URL")
            return deepLink
        }
        
        print("🔗 DeepLinkParser: Failed to parse URL with any parser: \(url)")
        return nil
    }
    
    public func registerParser(_ parser: DeepLinkURLParser, for key: String) {
        parsers[key] = parser
        print("🔗 DeepLinkParser: Registered parser '\(key)' with supported paths: \(parser.getSupportedPaths())")
    }
}
