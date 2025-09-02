//
//  DeepLink.swift
//  Mstsvlbl_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

public protocol DeepLink {
    var path: String { get }
    var parameters: [String: String] { get }
}

public struct DeepLinkContext {
    public let source: DeepLinkSource
    public let timestamp: Date
    
    public init(source: DeepLinkSource, timestamp: Date = Date()) {
        self.source = source
        self.timestamp = timestamp
    }
}

public enum DeepLinkSource {
    case customScheme
    case universalLink
    case userActivity
}

public enum DeepLinkResult {
    case success
    case failure(DeepLinkError)
}

public enum DeepLinkError: Error {
    case invalidURL
    case unsupportedPath
    case parsingFailed
    case navigationFailed
}
