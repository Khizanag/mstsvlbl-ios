//
//  DeepLinkPerformanceMetrics.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

// MARK: - DeepLink Performance Metrics
public struct DeepLinkPerformanceMetrics {
    public let averageSuccessTime: TimeInterval
    public let averageFailureTime: TimeInterval
    public let minimumTime: TimeInterval
    public let maximumTime: TimeInterval
    public let totalAnalytics: Int
    
    public init(
        averageSuccessTime: TimeInterval = 0,
        averageFailureTime: TimeInterval = 0,
        minimumTime: TimeInterval = 0,
        maximumTime: TimeInterval = 0,
        totalAnalytics: Int = 0
    ) {
        self.averageSuccessTime = averageSuccessTime
        self.averageFailureTime = averageFailureTime
        self.minimumTime = minimumTime
        self.maximumTime = maximumTime
        self.totalAnalytics = totalAnalytics
    }
}
