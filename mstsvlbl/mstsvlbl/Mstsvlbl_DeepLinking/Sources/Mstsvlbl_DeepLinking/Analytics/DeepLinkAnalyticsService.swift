//
//  DeepLinkAnalyticsService.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

// MARK: - DeepLink Analytics Service
public final class DeepLinkAnalyticsService {
    private var analytics: [DeepLinkAnalytics] = []
    
    public init() { }
    
    public func track(_ analytics: DeepLinkAnalytics) {
        self.analytics.append(analytics)
    }
    
    public func getStatistics() -> DeepLinkStatistics {
        let total = analytics.count
        let successful = analytics.filter { $0.success }.count
        let failed = analytics.filter { !$0.success }.count
        let ignored = 0 // Not tracked in current implementation
        
        let averageTime = analytics.isEmpty ? 0 : analytics.map { $0.processingTime }.reduce(0, +) / Double(analytics.count)
        
        let sourceCounts = Dictionary(grouping: analytics, by: { $0.source })
            .mapValues { $0.count }
        
        let typeCounts = Dictionary(grouping: analytics, by: { $0.deepLinkId })
            .mapValues { $0.count }
        
        return DeepLinkStatistics(
            totalDeepLinks: total,
            successfulDeepLinks: successful,
            failedDeepLinks: failed,
            ignoredDeepLinks: ignored,
            averageProcessingTime: averageTime,
            topSources: sourceCounts,
            topTypes: typeCounts
        )
    }
    
    public func getPerformanceMetrics() -> DeepLinkPerformanceMetrics {
        let successTimes = analytics.filter { $0.success }.map { $0.processingTime }
        let failureTimes = analytics.filter { !$0.success }.map { $0.processingTime }
        
        let avgSuccessTime = successTimes.isEmpty ? 0 : successTimes.reduce(0, +) / Double(successTimes.count)
        let avgFailureTime = failureTimes.isEmpty ? 0 : failureTimes.reduce(0, +) / Double(failureTimes.count)
        let minTime = analytics.isEmpty ? 0 : analytics.map { $0.processingTime }.min() ?? 0
        let maxTime = analytics.isEmpty ? 0 : analytics.map { $0.processingTime }.max() ?? 0
        
        return DeepLinkPerformanceMetrics(
            averageSuccessTime: avgSuccessTime,
            averageFailureTime: avgFailureTime,
            minimumTime: minTime,
            maximumTime: maxTime,
            totalAnalytics: analytics.count
        )
    }
    
    public func getSummary(for period: ClosedRange<Date>) -> DeepLinkSummary {
        let periodAnalytics = analytics.filter { period.contains($0.timestamp) }
        let total = periodAnalytics.count
        let successRate = total > 0 ? Double(periodAnalytics.filter { $0.success }.count) / Double(total) : 0
        let avgTime = periodAnalytics.isEmpty ? 0 : periodAnalytics.map { $0.processingTime }.reduce(0, +) / Double(periodAnalytics.count)
        
        let topSources = Dictionary(grouping: periodAnalytics, by: { $0.source })
            .mapValues { $0.count }
            .sorted { $0.value > $1.value }
            .prefix(5)
            .map { $0.key }
        
        return DeepLinkSummary(
            period: period,
            totalDeepLinks: total,
            successRate: successRate,
            averageProcessingTime: avgTime,
            topSources: Array(topSources)
        )
    }
    
    public func exportData() -> DeepLinkAnalyticsExport {
        let summary = getStatistics()
        return DeepLinkAnalyticsExport(analytics: analytics, summary: summary)
    }
    
    public func clear() {
        analytics.removeAll()
    }
}
