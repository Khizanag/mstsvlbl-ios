//
//  DeepLinkManager.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

@MainActor
@Observable
public final class DeepLinkManager {

    // MARK: - Properties
    public private(set) var isActive = false
    public private(set) var lastProcessedDeepLink: (any DeepLink)?
    public private(set) var processingCount = 0
    
    private var subscribers: [any DeepLinkSubscriber] = []
    private let parser: DeepLinkParser
    private let analyticsService: DeepLinkAnalyticsService
    
    // MARK: - Initialization
    public init() {
        self.parser = DeepLinkParser()
        self.analyticsService = DeepLinkAnalyticsService()
    }
    
    // MARK: - Public Methods
    
    /// Handle a deep link URL and notify subscribers
    public func handle(url: URL) async {
        print("✅ Deep link process")
        let result = await process(url)
        
        switch result {
        case .success(let deepLink):
            print("✅ Deep link processed successfully: \(deepLink)")
        case .failure(let error):
            print("❌ Deep link processing failed: \(error)")
        case .ignored(let deepLink):
            print("⏭️ Deep link ignored: \(deepLink)")
        }
    }
    
    /// Process a deep link from a URL
    public func process(_ url: URL, source: DeepLinkSource = .customScheme) async -> DeepLinkResult {
        processingCount += 1
        
        // Parse the URL into a DeepLink object
        guard let deepLink = parser.parse(url) else {
            let error = DeepLinkError.parsingFailed
            return .failure(error)
        }
        
        // Create context
        let context = DeepLinkContext(source: source)
        
        // Notify subscribers - they handle their own navigation
        await notifySubscribers(deepLink, context: context)
        
        // Update last processed
        lastProcessedDeepLink = deepLink
        
        return .success(deepLink)
    }
    
    /// Subscribe to deep link events
    public func subscribe(_ subscriber: any DeepLinkSubscriber) {
        guard !subscribers.contains(where: { $0.id == subscriber.id }) else { return }
        subscribers.append(subscriber)
        print("🔗 DeepLinkManager: Subscriber '\(subscriber.id)' registered for path '\(subscriber.subscribedPath)'")
    }
    
    /// Unsubscribe from deep link events
    public func unsubscribe(_ subscriber: any DeepLinkSubscriber) {
        subscribers.removeAll { $0.id == subscriber.id }
        print("🔗 DeepLinkManager: Subscriber '\(subscriber.id)' unregistered")
    }
    
    /// Unsubscribe by ID
    public func unsubscribe(id: String) {
        subscribers.removeAll { $0.id == id }
        print("🔗 DeepLinkManager: Subscriber with ID '\(id)' unregistered")
    }
    
    /// Get all active subscribers
    public func getAllSubscribers() -> [any DeepLinkSubscriber] {
        subscribers
    }
    
    /// Check if a subscriber is registered
    public func isSubscribed(_ subscriber: any DeepLinkSubscriber) -> Bool {
        subscribers.contains { $0.id == subscriber.id }
    }
    
    /// Clear all subscribers
    public func clearSubscribers() {
        subscribers.removeAll()
        print("🔗 DeepLinkManager: All subscribers cleared")
    }
    
    /// Get analytics summary
    public func getAnalyticsSummary() -> DeepLinkSummary {
        let now = Date()
        let oneMonthAgo = Calendar.current.date(byAdding: .month, value: -1, to: now) ?? now
        return analyticsService.getSummary(for: oneMonthAgo...now)
    }
    
    /// Export analytics data
    public func exportAnalytics() -> DeepLinkAnalyticsExport {
        return analyticsService.exportData()
    }
    
    // MARK: - Private Methods
    
    private func notifySubscribers(_ deepLink: any DeepLink, context: DeepLinkContext) async {
        let relevantSubscribers = subscribers.filter { subscriber in
            subscriber.canHandleDeepLink(deepLink)
        }
        
        print("🔗 DeepLinkManager: Notifying \(relevantSubscribers.count) subscribers for deep link: \(deepLink.path)")
        
        for subscriber in relevantSubscribers {
            print("🔗 DeepLinkManager: Notifying subscriber '\(subscriber.id)' for path '\(subscriber.subscribedPath)'")
            await MainActor.run {
                subscriber.didReceiveDeepLink(deepLink, context: context)
            }
        }
    }
}

// MARK: - Deep Link Manager Extensions

public extension DeepLinkManager {
    
    /// Process a deep link from a URL string
    func process(_ urlString: String, source: DeepLinkSource = .customScheme) async -> DeepLinkResult {
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }
        return await process(url, source: source)
    }
    
    /// Process multiple deep links
    func process(_ urls: [URL], source: DeepLinkSource = .customScheme) async -> [DeepLinkResult] {
        await withTaskGroup(of: DeepLinkResult.self) { group in
            for url in urls {
                group.addTask {
                    await self.process(url, source: source)
                }
            }
            
            var results: [DeepLinkResult] = []
            for await result in group {
                results.append(result)
            }
            return results
        }
    }
    
    /// Process multiple deep link strings
    func process(_ urlStrings: [String], source: DeepLinkSource = .customScheme) async -> [DeepLinkResult] {
        let urls = urlStrings.compactMap { URL(string: $0) }
        return await process(urls, source: source)
    }
}
