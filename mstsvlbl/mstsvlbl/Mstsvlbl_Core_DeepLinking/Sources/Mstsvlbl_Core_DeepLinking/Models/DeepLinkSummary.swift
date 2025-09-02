//
//  DeepLinkSummary.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

public struct DeepLinkSummary {
    public let period: ClosedRange<Date>
    public let totalDeepLinks: Int
    public let successRate: Double
    public let averageProcessingTime: TimeInterval
    public let topSources: [DeepLinkSource]
    
    public init(
        period: ClosedRange<Date>,
        totalDeepLinks: Int = 0,
        successRate: Double = 0.0,
        averageProcessingTime: TimeInterval = 0.0,
        topSources: [DeepLinkSource] = []
    ) {
        self.period = period
        self.totalDeepLinks = totalDeepLinks
        self.successRate = successRate
        self.averageProcessingTime = averageProcessingTime
        self.topSources = topSources
    }
}
