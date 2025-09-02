//
//  DeepLinkAnalytics.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

// MARK: - DeepLink Analytics
public struct DeepLinkAnalytics {
    public let deepLinkId: String
    public let timestamp: Date
    public let source: DeepLinkSource
    public let success: Bool
    public let processingTime: TimeInterval
    public let error: DeepLinkError?
    
    public init(
        deepLinkId: String,
        timestamp: Date = Date(),
        source: DeepLinkSource,
        success: Bool,
        processingTime: TimeInterval,
        error: DeepLinkError? = nil
    ) {
        self.deepLinkId = deepLinkId
        self.timestamp = timestamp
        self.source = source
        self.success = success
        self.processingTime = processingTime
        self.error = error
    }
}
