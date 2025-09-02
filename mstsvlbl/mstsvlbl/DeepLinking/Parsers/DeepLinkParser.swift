//
//  DeepLinkParser.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

// MARK: - DeepLink Parser
public final class DeepLinkParser {
    private var parsers: [String: DeepLinkURLParser] = [:]
    
    public init() {
        setupDefaultParsers()
    }
    
    private func setupDefaultParsers() {
        register(UniversalLinkParser(), for: "https")
        register(CustomSchemeParser(), for: "mstsvlbl")
    }
    
    public func register(_ parser: DeepLinkURLParser, for scheme: String) {
        parsers[scheme] = parser
    }
    
    public func parse(_ url: URL) -> (any DeepLink)? {
        guard let scheme = url.scheme?.lowercased(),
              let parser = parsers[scheme] else {
            return nil
        }
        
        return parser.parse(url)
    }
    
    public func getSupportedSchemes() -> [String] {
        Array(parsers.keys)
    }
    
    public func getSupportedPaths() -> [String] {
        parsers.values.flatMap { $0.getSupportedPaths() }
    }
}

// MARK: - DeepLink URL Parser Protocol
public protocol DeepLinkURLParser {
    func parse(_ url: URL) -> (any DeepLink)?
    func getSupportedPaths() -> [String]
}
