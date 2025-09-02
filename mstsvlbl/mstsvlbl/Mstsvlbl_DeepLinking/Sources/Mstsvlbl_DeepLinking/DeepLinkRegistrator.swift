//
//  DeepLinkRegistrator.swift
//  Mstsvlbl_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

@MainActor
public final class DeepLinkRegistrator {
    
    private let deepLinkManager: DeepLinkManager
    private let subscriberFactories: [() async -> any DeepLinkSubscriber]
    
    public init(deepLinkManager: DeepLinkManager, subscriberFactories: [() async -> any DeepLinkSubscriber]) {
        self.deepLinkManager = deepLinkManager
        self.subscriberFactories = subscriberFactories
    }
    
    public func registerAllSubscribers() async {
        print("🔗 DeepLinkRegistrator: Starting subscriber registration...")
        
        for (index, factory) in subscriberFactories.enumerated() {
            let subscriber = await factory()
            deepLinkManager.subscribe(subscriber)
            print("🔗 DeepLinkRegistrator: \(type(of: subscriber)) registered (\(index + 1)/\(subscriberFactories.count))")
        }
        
        print("🔗 DeepLinkRegistrator: All subscribers registered successfully")
    }
    
    public func getRegisteredSubscriberCount() -> Int {
        subscriberFactories.count
    }
    
    public func listRegisteredSubscribers() -> [String] {
        subscriberFactories.map { _ in
            "Subscriber Factory"
        }
    }
}
