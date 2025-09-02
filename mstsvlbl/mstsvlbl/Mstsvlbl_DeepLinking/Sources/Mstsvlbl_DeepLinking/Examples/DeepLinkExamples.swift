//
//  DeepLinkExamples.swift
//  Mstsvlbl_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

// MARK: - Example Deep Link Subscriber

@MainActor
public final class ExampleDeepLinkSubscriber: DeepLinkSubscriber {
    public let id = "ExampleDeepLinkSubscriber"
    public let subscribedPath = "example"
    
    public init() {}
    
    public func didReceiveDeepLink(_ deepLink: any DeepLink, context: DeepLinkContext) async {
        print("📱 ExampleDeepLinkSubscriber: Received deep link")
        print("📱 ExampleDeepLinkSubscriber: Path: \(deepLink.path)")
        print("📱 ExampleDeepLinkSubscriber: Parameters: \(deepLink.parameters)")
        print("📱 ExampleDeepLinkSubscriber: Source: \(context.source)")
        print("📱 ExampleDeepLinkSubscriber: Timestamp: \(context.timestamp)")
    }
}

// MARK: - Example Usage

public struct DeepLinkExamples {
    
    public static func createExampleContexts() -> [DeepLinkContext] {
        return [
            DeepLinkContext(source: .customScheme),
            DeepLinkContext(source: .universalLink),
            DeepLinkContext(source: .userActivity)
        ]
    }
    
    @MainActor
    public static func demonstrateDeepLinkHandling() async {
        let subscriber = ExampleDeepLinkSubscriber()
        let contexts = createExampleContexts()
        
        print("🔗 DeepLinkExamples: Demonstrating deep link handling...")
        
        for context in contexts {
            print("🔗 DeepLinkExamples: Context source: \(context.source)")
        }
        
        print("🔗 DeepLinkExamples: Example subscriber ID: \(subscriber.id)")
        print("🔗 DeepLinkExamples: Example subscriber path: \(subscriber.subscribedPath)")
    }
}
