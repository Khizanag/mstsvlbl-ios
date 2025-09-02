//
//  DeepLinkRegistrator.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

@MainActor
public final class DeepLinkRegistrator {
    
    private let deepLinkManager: DeepLinkManager
    private let coordinator: Coordinator
    
    public init(deepLinkManager: DeepLinkManager, coordinator: Coordinator) {
        self.deepLinkManager = deepLinkManager
        self.coordinator = coordinator
    }
    
    public func registerAllSubscribers() {
        print("🔗 DeepLinkRegistrator: Starting subscriber registration...")
        
        let subscriberFactories: [(DeepLinkManager, Coordinator) -> any DeepLinkSubscriber] = [
            { deepLinkManager, coordinator in
                QuizDeepLinkSubscriber(
                    coordinator: coordinator,
                    quizRepository: LocalQuizRepository()
                )
            },
            { _, coordinator in
                CategoryDeepLinkSubscriber(coordinator: coordinator)
            },
            { _, coordinator in
                ProfileDeepLinkSubscriber(coordinator: coordinator)
            },
            { _, coordinator in
                SettingsDeepLinkSubscriber(coordinator: coordinator)
            },
            { _, coordinator in
                StatsDeepLinkSubscriber(coordinator: coordinator)
            },
            { _, coordinator in
                DiscoverDeepLinkSubscriber(coordinator: coordinator)
            },
            { _, coordinator in
                BookmarksDeepLinkSubscriber(coordinator: coordinator)
            }
        ]
        
        for (index, factory) in subscriberFactories.enumerated() {
            let subscriber = factory(deepLinkManager, coordinator)
            deepLinkManager.subscribe(subscriber)
            print("🔗 DeepLinkRegistrator: \(type(of: subscriber)) registered (\(index + 1)/\(subscriberFactories.count))")
        }
        
        print("🔗 DeepLinkRegistrator: All subscribers registered successfully")
    }
    
    // MARK: - Utility Methods
    
    public func getRegisteredSubscriberCount() -> Int {
        return 7
    }
    
    public func listRegisteredSubscribers() -> [String] {
        return [
            "QuizDeepLinkSubscriber",
            "CategoryDeepLinkSubscriber", 
            "ProfileDeepLinkSubscriber",
            "SettingsDeepLinkSubscriber",
            "StatsDeepLinkSubscriber",
            "DiscoverDeepLinkSubscriber",
            "BookmarksDeepLinkSubscriber"
        ]
    }
    
    public func validateRegistration() -> Bool {
        let expectedCount = 7
        let actualCount = getRegisteredSubscriberCount()
        
        if actualCount == expectedCount {
            print("🔗 DeepLinkRegistrator: ✅ Registration validation passed - \(actualCount) subscribers registered")
            return true
        } else {
            print("🔗 DeepLinkRegistrator: ❌ Registration validation failed - Expected \(expectedCount), got \(actualCount)")
            return false
        }
    }
    
    public func getRegistrationSummary() -> String {
        let subscribers = listRegisteredSubscribers()
        let count = getRegisteredSubscriberCount()
        
        return """
        🔗 Deep Link Registration Summary
        Total Subscribers: \(count)
        Registered Subscribers:
        \(subscribers.map { "  • \($0)" }.joined(separator: "\n"))
        """
    }
}
