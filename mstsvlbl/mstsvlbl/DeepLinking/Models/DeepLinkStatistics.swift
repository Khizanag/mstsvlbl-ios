//
//  DeepLinkStatistics.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

public struct DeepLinkStatistics {
    public let totalDeepLinks: Int
    public let successfulDeepLinks: Int
    public let failedDeepLinks: Int
    public let ignoredDeepLinks: Int
    public let averageProcessingTime: TimeInterval
    public let topSources: [DeepLinkSource: Int]
    public let topTypes: [String: Int]
    
    public init(
        totalDeepLinks: Int = 0,
        successfulDeepLinks: Int = 0,
        failedDeepLinks: Int = 0,
        ignoredDeepLinks: Int = 0,
        averageProcessingTime: TimeInterval = 0,
        topSources: [DeepLinkSource: Int] = [:],
        topTypes: [String: Int] = [:]
    ) {
        self.totalDeepLinks = totalDeepLinks
        self.successfulDeepLinks = successfulDeepLinks
        self.failedDeepLinks = failedDeepLinks
        self.ignoredDeepLinks = ignoredDeepLinks
        self.averageProcessingTime = averageProcessingTime
        self.topSources = topSources
        self.topTypes = topTypes
    }
}
