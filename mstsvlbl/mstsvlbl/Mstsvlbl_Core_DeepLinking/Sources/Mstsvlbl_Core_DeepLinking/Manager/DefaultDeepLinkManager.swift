//
//  DefaultDeepLinkManager.swift
//  Mstsvlbl_Core_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

@MainActor
public final class DefaultDeepLinkManager: DeepLinkManager {
    
    private var subscribers: [any DeepLinkSubscriber] = []
    private nonisolated let parser: DeepLinkParser
    
    public nonisolated init(parser: DeepLinkParser = DeepLinkParser()) {
        self.parser = parser
        self.subscribers = []
    }
    
    public func handle(url: URL) async {
        guard let deepLink = parser.parse(url) else {
            print("🔗 DefaultDeepLinkManager: Failed to parse URL: \(url)")
            return
        }
        
        await process(deepLink, source: .customScheme)
    }
    
    public func handle(universalLink: URL) async {
        guard let deepLink = parser.parse(universalLink) else {
            print("🔗 DefaultDeepLinkManager: Failed to parse universal link: \(universalLink)")
            return
        }
        
        await process(deepLink, source: .userActivity)
    }
    
    public func register(_ subscriber: any DeepLinkSubscriber) async {
        subscribers.append(subscriber)
        print("🔗 DefaultDeepLinkManager: Registered subscriber: \(type(of: subscriber))")
    }
    
    public func unregister(_ subscriber: any DeepLinkSubscriber) async {
        subscribers.removeAll { $0.id == subscriber.id }
        print("🔗 DefaultDeepLinkManager: Unregistered subscriber: \(type(of: subscriber))")
    }
}

// MARK: - Private
private extension DefaultDeepLinkManager {
    func process(_ deepLink: DeepLink, source: DeepLinkSource) async {
        print("🔗 DefaultDeepLinkManager: Processing deep link with name: \(deepLink.name)")
        
        let matchingSubscribers = subscribers.filter { $0.canHandleDeepLink(deepLink) }
        
        if matchingSubscribers.isEmpty {
            print("🔗 DefaultDeepLinkManager: No subscribers found for name: \(deepLink.name)")
            return
        }
        
        print("🔗 DefaultDeepLinkManager: Found \(matchingSubscribers.count) subscriber(s) for name: \(deepLink.name)")
        
        let context = DeepLinkContext(source: source)
        
        for subscriber in matchingSubscribers {
            print("🔗 DefaultDeepLinkManager: Notifying subscriber: \(type(of: subscriber))")
            await subscriber.didReceiveDeepLink(deepLink, context: context)
        }
    }
}
