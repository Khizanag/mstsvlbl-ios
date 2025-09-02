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
        
        do {
            let deepLink = try parseDeepLink(from: url)
            return await process(deepLink, source: .customScheme)
        } catch {
            print("🔗 DeepLinkManager: Failed to parse URL: \(error)")
            return .failure(.parsingFailed)
        }
    }
    
    public func handle(userActivity: NSUserActivity) async -> DeepLinkResult {
        print("🔗 DeepLinkManager: Processing user activity")
        
        guard let url = userActivity.webpageURL else {
            print("🔗 DeepLinkManager: No webpage URL in user activity")
            return .failure(.invalidURL)
        }
        
        do {
            let deepLink = try parseDeepLink(from: url)
            return await process(deepLink, source: .userActivity)
        } catch {
            print("🔗 DeepLinkManager: Failed to parse user activity URL: \(error)")
            return .failure(.parsingFailed)
        }
    }
    
    private func parseDeepLink(from url: URL) throws -> any DeepLink {
        // Simple parsing - extract path and query parameters
        let path = url.pathComponents.dropFirst().joined(separator: "/")
        var parameters: [String: String] = [:]
        
        if let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems {
            for item in queryItems {
                if let value = item.value {
                    parameters[item.name] = value
                }
            }
        }
        
        // Create a simple deep link
        return SimpleDeepLink(path: path, parameters: parameters)
    }
    
    private func process(_ deepLink: any DeepLink, source: DeepLinkSource) async -> DeepLinkResult {
        print("🔗 DeepLinkManager: Processing deep link: \(deepLink.path)")
        
        let context = DeepLinkContext(source: source)
        var handled = false
        
        for subscriber in subscribers {
            if subscriber.canHandleDeepLink(deepLink) {
                print("🔗 DeepLinkManager: \(type(of: subscriber)) can handle this deep link")
                await subscriber.didReceiveDeepLink(deepLink, context: context)
                handled = true
            }
        }
        
        if handled {
            print("🔗 DeepLinkManager: Deep link processed successfully")
            return .success
        } else {
            print("🔗 DeepLinkManager: No subscriber found for deep link: \(deepLink.path)")
            return .failure(.unsupportedPath)
        }
    }
}

// MARK: - Simple Deep Link Implementation

private struct SimpleDeepLink: DeepLink {
    typealias ID = String
    let id = UUID().uuidString
    let path: String
    let parameters: [String: String]
    
    // Conformance to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(path)
        hasher.combine(parameters)
    }
    
    static func == (lhs: SimpleDeepLink, rhs: SimpleDeepLink) -> Bool {
        lhs.path == rhs.path && lhs.parameters == rhs.parameters
    }
}
