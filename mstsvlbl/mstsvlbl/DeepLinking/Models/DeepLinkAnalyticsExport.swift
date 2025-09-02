//
//  DeepLinkAnalyticsExport.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

public struct DeepLinkAnalyticsExport {
    public let exportDate: Date
    public let analytics: [DeepLinkAnalytics]
    public let summary: DeepLinkStatistics
    
    public init(analytics: [DeepLinkAnalytics], summary: DeepLinkStatistics) {
        self.exportDate = Date()
        self.analytics = analytics
        self.summary = summary
    }
}
