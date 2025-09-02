//
//  DeepLinkHandlerChain.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

// MARK: - DeepLink Handler Chain
public final class DeepLinkHandlerChain {
    private let factory: DeepLinkHandlerFactory
    
    public init(factory: DeepLinkHandlerFactory) {
        self.factory = factory
    }
    
    public func execute(_ deepLink: any DeepLink, context: DeepLinkContext) async -> DeepLinkResult {
        let handlers = factory.getAllHandlers()
            .filter { $0.isEnabled && $0.canHandle(deepLink) }
            .sorted { handler1, handler2 in
                handler1.metadata.priority < handler2.metadata.priority
            }
        
        for handler in handlers {
            do {
                let result = try await executeHandler(handler, with: deepLink, context: context)
                if result.isSuccess || result.isFailure {
                    return result
                }
                // Continue to next handler if ignored
            } catch {
                return .failure(.routingFailed)
            }
        }
        
        return .failure(.routingFailed)
    }
    
    private func executeHandler<T: DeepLinkHandler>(_ handler: T, with deepLink: any DeepLink, context: DeepLinkContext) async throws -> DeepLinkResult {
        guard let typedDeepLink = deepLink as? T.LinkType else {
            throw DeepLinkError.routingFailed
        }
        
        // Validate
        if let error = handler.validate(typedDeepLink) {
            return .failure(error)
        }
        
        // Preprocess
        let processedContext = await handler.preprocess(typedDeepLink, context: context)
        
        // Handle
        return await handler.handle(typedDeepLink, context: processedContext)
    }
}
