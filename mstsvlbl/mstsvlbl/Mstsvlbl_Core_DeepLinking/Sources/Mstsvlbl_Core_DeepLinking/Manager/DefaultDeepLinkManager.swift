//
//  DefaultDeepLinkManager.swift
//  Mstsvlbl_Core_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

@MainActor
public final class DefaultDeepLinkManager: DeepLinkManager {
    
    private var handlers: [any DeepLinkHandler] = []
    private nonisolated let parser: DeepLinkParser
    
    public nonisolated init(parser: DeepLinkParser = DeepLinkParser()) {
        self.parser = parser
        self.handlers = []
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
    
    public func register(_ handler: any DeepLinkHandler) async {
        handlers.append(handler)
        print("🔗 DefaultDeepLinkManager: Registered handler: \(type(of: handler))")
    }
    
    public func unregister(_ handler: any DeepLinkHandler) async {
        handlers.removeAll { $0.id == handler.id }
        print("🔗 DefaultDeepLinkManager: Unregistered handler: \(type(of: handler))")
    }
}

// MARK: - Private
private extension DefaultDeepLinkManager {
    func process(_ deepLink: DeepLink, source: DeepLinkSource) async {
        print("🔗 DefaultDeepLinkManager: Processing deep link with name: \(deepLink.name)")
        
        let matchingHandlers = handlers.filter { $0.canHandleDeepLink(deepLink) }
        
        if matchingHandlers.isEmpty {
            print("🔗 DefaultDeepLinkManager: No handlers found for name: \(deepLink.name)")
            return
        }
        
        print("🔗 DefaultDeepLinkManager: Found \(matchingHandlers.count) handler(s) for name: \(deepLink.name)")
        
        let context = DeepLinkContext(source: source)
        
        for handler in matchingHandlers {
            print("🔗 DefaultDeepLinkManager: Notifying handler: \(type(of: handler))")
            await handler.handle(deepLink, context: context)
        }
    }
}
