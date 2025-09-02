//
//  DeepLinkExamples.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

// MARK: - DeepLink Examples
public struct DeepLinkExamples {
    
    // MARK: - Example URLs
    public static let exampleURLs = [
        "mstsvlbl://quiz?id=math_quiz&action=play",
        "mstsvlbl://category?name=science",
        "mstsvlbl://profile?action=edit",
        "mstsvlbl://settings?section=notifications",
        "mstsvlbl://discover?filter=popular&sort=rating",
        "mstsvlbl://bookmarks?filter=favorites",
        "mstsvlbl://stats?period=monthly"
    ]
    
    // MARK: - Example Deep Links
    public static let exampleDeepLinks: [any DeepLink] = [
        QuizDeepLink(id: "math_quiz", action: "play"),
        CategoryDeepLink(id: "science"),
        ProfileDeepLink(id: "user123", action: "edit"),
        SettingsDeepLink(id: "settings", section: "notifications"),
        DiscoverDeepLink(id: "discover", filter: "popular", sort: "rating"),
        BookmarksDeepLink(id: "bookmarks", filter: "favorites"),
        StatsDeepLink(id: "stats", period: "monthly")
    ]
    
    // MARK: - Example Contexts
    public static let exampleContexts = [
        DeepLinkContext(source: .appLaunch),
        DeepLinkContext(source: .universalLink),
        DeepLinkContext(source: .customScheme),
        DeepLinkContext(source: .pushNotification),
        DeepLinkContext(source: .background),
        DeepLinkContext(source: .foreground)
    ]
}

// MARK: - Example Deep Link Subscriber
public final class ExampleDeepLinkSubscriber: DeepLinkSubscriber {
    public let id = "ExampleDeepLinkSubscriber"
    public let subscribedPath = "example"
    
    public init() {}
    
    public func didReceiveDeepLink(_ deepLink: any DeepLink, context: DeepLinkContext) {
        print("📱 ExampleDeepLinkSubscriber: Received deep link: \(deepLink.path) with ID: \(deepLink.id)")
        print("📱 ExampleDeepLinkSubscriber: Source: \(context.source.displayName)")
        print("📱 ExampleDeepLinkSubscriber: Timestamp: \(context.timestamp)")
    }
}

// MARK: - Testing Methods
public extension DeepLinkExamples {
    
    /// Test deep link parsing
    static func testDeepLinkParsing() {
        print("🧪 Testing Deep Link Parsing...")
        
        for example in exampleURLs {
            if URL(string: example) != nil {
                print("  ✅ Valid URL: \(example)")
            } else {
                print("  ❌ Invalid URL: \(example)")
            }
        }
    }
    
    @MainActor
    static func testSubscriberRegistration() async {
        print("🧪 Testing Subscriber Registration...")
        
        let manager = DeepLinkManager()
        let subscriber = ExampleDeepLinkSubscriber()
        
        // Test subscription
        manager.subscribe(subscriber)
        print("  ✅ Subscriber registered")
        
        // Test getting all subscribers
        let allSubscribers = manager.getAllSubscribers()
        print("  📊 Total subscribers: \(allSubscribers.count)")
        
        // Test unsubscription
        manager.unsubscribe(subscriber)
        print("  ✅ Subscriber unregistered")
        
        let remainingSubscribers = manager.getAllSubscribers()
        print("  📊 Remaining subscribers: \(remainingSubscribers.count)")
    }
}
