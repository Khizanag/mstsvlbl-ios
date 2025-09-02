//
//  DeepLinkManager.swift
//  Mstsvlbl_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

@MainActor
public final class DeepLinkManager {
    
    private var subscribers: [any DeepLinkSubscriber] = []
    
    public init() {}
    
    public func subscribe(_ subscriber: any DeepLinkSubscriber) {
        subscribers.append(subscriber)
        print("🔗 DeepLinkManager: Subscribed \(type(of: subscriber))")
    }
    
    public func unsubscribe(_ subscriber: any DeepLinkSubscriber) {
        subscribers.removeAll { $0.id == subscriber.id }
        print("🔗 DeepLinkManager: Unsubscribed \(type(of: subscriber))")
    }
    
    public func handle(url: URL) async -> DeepLinkResult {
        print("🔗 DeepLinkManager: Processing URL: \(url)")
        
        // For now, just notify all subscribers
        // In a real implementation, you'd parse the URL and route to specific subscribers
        let context = DeepLinkContext(source: .customScheme)
        
        for subscriber in subscribers {
            print("🔗 DeepLinkManager: Notifying \(type(of: subscriber))")
            // This is a simplified implementation
            // In practice, you'd parse the URL and only notify relevant subscribers
        }
        
        return .success
    }
}
