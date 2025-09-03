//
//  DeepLinkParser.swift
//  Mstsvlbl_Core_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

public final class DeepLinkParser: Sendable {
    private let parsers: [DeepLinkURLParser] = [
        UniversalLinkParser(),
        CustomSchemeParser(scheme: "tbc-uz"),
    ]
    
    public init() { }
    
    public func parse(_ url: URL) -> DeepLink? {
        for parser in parsers {
            if let deepLink = parser.parse(url) {
                return deepLink
            }
        }
        
        return nil
    }
}
