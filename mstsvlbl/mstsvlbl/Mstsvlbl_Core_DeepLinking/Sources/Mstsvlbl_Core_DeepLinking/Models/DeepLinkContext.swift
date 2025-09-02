//
//  DeepLinkContext.swift
//  Mstsvlbl_Core_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

public struct DeepLinkContext: Sendable {
    public let source: DeepLinkSource
    public let timestamp: Date
    
    public init(source: DeepLinkSource, timestamp: Date = Date()) {
        self.source = source
        self.timestamp = timestamp
    }
}
