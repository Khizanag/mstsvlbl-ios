//
//  DeepLinkRegistrator.swift
//  Mstsvlbl_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

@MainActor
public final class DeepLinkRegistrator {
    
    private let deepLinkManager: DeepLinkManager
    private let subscriberFactories: [() -> any DeepLinkSubscriber]
    
    public init(deepLinkManager: DeepLinkManager, subscriberFactories: [() -> any DeepLinkSubscriber]) {
        self.deepLinkManager = deepLinkManager
        self.subscriberFactories = subscriberFactories
    }
    
    public func registerAllSubscribers() {
        print("🔗 DeepLinkRegistrator: Starting subscriber registration...")
        
        for (index, factory) in subscriberFactories.enumerated() {
            let subscriber = factory()
            deepLinkManager.subscribe(subscriber)
            print("🔗 DeepLinkRegistrator: \(type(of: subscriber)) registered (\(index + 1)/\(subscriberFactories.count))")
        }
        
        print("🔗 DeepLinkRegistrator: All subscribers registered successfully")
    }
    
    // MARK: - Utility Methods
    
    public func getRegisteredSubscriberCount() -> Int {
        return subscriberFactories.count
    }
    
    public func listRegisteredSubscribers() -> [String] {
        return subscriberFactories.map { factory in
            let subscriber = factory()
            return String(describing: type(of: subscriber))
        }
    }
    
    public func validateRegistration() -> Bool {
        let expectedCount = subscriberFactories.count
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
