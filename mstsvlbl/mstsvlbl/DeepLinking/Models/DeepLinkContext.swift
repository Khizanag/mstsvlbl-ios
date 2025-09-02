//
//  DeepLinkContext.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

// MARK: - DeepLink Context
public struct DeepLinkContext {
    public let source: DeepLinkSource
    public let timestamp: Date
    public var userInfo: [String: Any]
    
    public init(source: DeepLinkSource, timestamp: Date = Date(), userInfo: [String: Any] = [:]) {
        self.source = source
        self.timestamp = timestamp
        self.userInfo = userInfo
    }
}
