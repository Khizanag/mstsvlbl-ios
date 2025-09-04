//
//  DefaultDeepLinkManager.swift
//  Mstsvlbl_Core_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

@MainActor
public final class DefaultDeepLinkManager: DeepLinkManager {
    
    private var handlers: [String: any DeepLinkHandler] = [:]
    private nonisolated let parser: DeepLinkParser
    var savedDeepLink: DeepLink?
    
    public init(parser: DeepLinkParser = DeepLinkParser()) {
        self.parser = parser
    }
    
    public func handle(url: URL) async {
        guard let deepLink = parser.parse(url) else {
            return
        }
        
        let result = await process(deepLink, source: .customScheme)
        if case .failure(let error) = result, error == .loginRequired {
            savedDeepLink = deepLink
        }
    }
    
    public func register(_ handler: any DeepLinkHandler) async {
        handlers[handler.host] = handler
    }
}

// MARK: - Private
private extension DefaultDeepLinkManager {
    func process(_ deepLink: DeepLink, source: DeepLinkSource) async -> DeepLinkResult {
        let context = DeepLinkContext(source: source)
        guard let handler = handlers[deepLink.name] else {
            return .failure(.unsupportedPath)
        }
        return await handler.handle(deepLink.parameters, context: context)
    }
}
