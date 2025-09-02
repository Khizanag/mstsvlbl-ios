//
//  DeepLinkManager.swift
//  Mstsvlbl_Core_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

@MainActor
public final class DeepLinkManager {
    
    private var subscribers: [any DeepLinkSubscriber] = []
    private let parser: DeepLinkParser
    
    public init(parser: DeepLinkParser = DeepLinkParser()) {
        self.parser = parser
    }
    
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
        
        guard let deepLink = parser.parse(url) else {
            let error = DeepLinkError.parsingFailed
            return .failure(error)
        }
        
        let result = await process(deepLink, source: .customScheme)
        return result
    }
    
    public func handle(userActivity: NSUserActivity) async -> DeepLinkResult {
        print("🔗 DeepLinkManager: Processing user activity")
        
        guard let url = userActivity.webpageURL else {
            let error = DeepLinkError.invalidURL
            return .failure(error)
        }
        
        guard let deepLink = parser.parse(url) else {
            let error = DeepLinkError.parsingFailed
            return .failure(error)
        }
        
        let result = await process(deepLink, source: .userActivity)
        return result
    }
    
    private func process(_ deepLink: any DeepLink, source: DeepLinkSource) async -> DeepLinkResult {
        print("🔗 DeepLinkManager: Processing deep link with path: \(deepLink.path)")
        
        let matchingSubscribers = subscribers.filter { $0.canHandleDeepLink(deepLink) }
        
        if matchingSubscribers.isEmpty {
            print("🔗 DeepLinkManager: No subscribers found for path: \(deepLink.path)")
            return .failure(.unsupportedPath)
        }
        
        print("🔗 DeepLinkManager: Found \(matchingSubscribers.count) subscriber(s) for path: \(deepLink.path)")
        
        let context = DeepLinkContext(source: source)
        
        for subscriber in matchingSubscribers {
            print("🔗 DeepLinkManager: Notifying subscriber: \(type(of: subscriber))")
            await subscriber.didReceiveDeepLink(deepLink, context: context)
        }
        
        return .success
    }
}


