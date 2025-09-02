//
//  DeepLinkManager.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

// MARK: - Deep Link Subscriber Protocol
public protocol DeepLinkSubscriber: AnyObject {
    var id: String { get }
    var name: String { get }
    
    func didReceiveDeepLink(_ deepLink: any DeepLink, context: DeepLinkContext)
    func canHandleDeepLink(_ deepLink: any DeepLink) -> Bool
}

// MARK: - Deep Link Manager
@Observable
public final class DeepLinkManager: NSObject {
    
    // MARK: - Properties
    public private(set) var isActive = false
    public private(set) var lastProcessedDeepLink: (any DeepLink)?
    public private(set) var processingCount = 0
    
    private var subscribers: [DeepLinkSubscriber] = []
    private let parser: DeepLinkParser
    private let router: DeepLinkRouter
    private let analyticsService: DeepLinkAnalyticsService
    private let handlerRegistry: DeepLinkHandlerRegistry
    
    // MARK: - Initialization
    public override init() {
        self.parser = DeepLinkParser()
        self.router = DeepLinkRouter()
        self.analyticsService = DeepLinkAnalyticsService()
        self.handlerRegistry = DeepLinkHandlerRegistry()
        
        super.init()
        
        setupDefaultHandlers()
        setupDefaultRoutes()
    }
    
    // MARK: - Public Methods
    
    /// Process a deep link from a URL
    public func process(_ url: URL, source: DeepLinkSource = .customScheme) async -> DeepLinkResult {
        processingCount += 1
        
        do {
            // Parse the URL into a DeepLink object
            guard let deepLink = parser.parse(url) else {
                let error = DeepLinkError.parsingFailed
                return .failure(error)
            }
            
            // Create context
            let context = DeepLinkContext(source: source)
            
            // Notify subscribers
            await notifySubscribers(deepLink, context: context)
            
            // Route the deep link
            let routingResult = router.route(deepLink)
            
            // Update last processed
            lastProcessedDeepLink = deepLink
            
            return .success(deepLink)
            
        } catch {
            let deepLinkError = error as? DeepLinkError ?? DeepLinkError.parsingFailed
            return .failure(deepLinkError)
        }
    }
    
    /// Subscribe to deep link events
    public func subscribe(_ subscriber: DeepLinkSubscriber) {
        guard !subscribers.contains(where: { $0.id == subscriber.id }) else { return }
        subscribers.append(subscriber)
    }
    
    /// Unsubscribe from deep link events
    public func unsubscribe(_ subscriber: DeepLinkSubscriber) {
        subscribers.removeAll { $0.id == subscriber.id }
    }
    
    /// Unsubscribe by ID
    public func unsubscribe(id: String) {
        subscribers.removeAll { $0.id == id }
    }
    
    /// Get all active subscribers
    public func getAllSubscribers() -> [DeepLinkSubscriber] {
        subscribers
    }
    
    /// Check if a subscriber is registered
    public func isSubscribed(_ subscriber: DeepLinkSubscriber) -> Bool {
        subscribers.contains { $0.id == subscriber.id }
    }
    
    /// Clear all subscribers
    public func clearSubscribers() {
        subscribers.removeAll()
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
    
    // MARK: - Testing Methods
    
    /// Get all registered handlers (for testing)
    public func getAllHandlers() -> [any DeepLinkHandler] {
        handlerRegistry.getAllHandlers()
    }
    
    /// Get all registered routes (for testing)
    public func getRegisteredRoutes() -> [String] {
        router.getRegisteredRoutes()
    }
    
    // MARK: - Private Methods
    
    private func setupDefaultHandlers() {
        handlerRegistry.register(QuizDeepLinkHandler())
        handlerRegistry.register(CategoryDeepLinkHandler())
        handlerRegistry.register(ProfileDeepLinkHandler())
        handlerRegistry.register(SettingsDeepLinkHandler())
        handlerRegistry.register(DiscoverDeepLinkHandler())
        handlerRegistry.register(BookmarksDeepLinkHandler())
        handlerRegistry.register(StatsDeepLinkHandler())
        handlerRegistry.register(CustomDeepLinkHandler())
    }
    
    private func setupDefaultRoutes() {
        router.register(QuizDeepLinkRoute(), for: "quiz")
        router.register(CategoryDeepLinkRoute(), for: "category")
        router.register(ProfileDeepLinkRoute(), for: "profile")
        router.register(SettingsDeepLinkRoute(), for: "settings")
        router.register(DiscoverDeepLinkRoute(), for: "discover")
        router.register(BookmarksDeepLinkRoute(), for: "bookmarks")
        router.register(StatsDeepLinkRoute(), for: "stats")
    }
    
    private func notifySubscribers(_ deepLink: any DeepLink, context: DeepLinkContext) async {
        let relevantSubscribers = subscribers.filter { subscriber in
            subscriber.canHandleDeepLink(deepLink)
        }
        
        for subscriber in relevantSubscribers {
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
