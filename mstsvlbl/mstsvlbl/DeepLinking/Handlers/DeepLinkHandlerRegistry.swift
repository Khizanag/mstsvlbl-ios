//
//  DeepLinkHandlerRegistry.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

// MARK: - DeepLink Handler Registry
public final class DeepLinkHandlerRegistry: DeepLinkHandlerFactory {
    private var handlers: [String: any DeepLinkHandler] = [:]
    
    public init() {}
    
    public func register<T: DeepLinkHandler>(_ handler: T) {
        let key = String(describing: T.LinkType.self)
        handlers[key] = handler
    }
    
    public func unregister<T: DeepLinkHandler>(_ handler: T) {
        let key = String(describing: T.LinkType.self)
        handlers.removeValue(forKey: key)
    }
    
    public func getHandler<T: DeepLinkHandler>(for type: T.Type) -> T? {
        let key = String(describing: T.LinkType.self)
        return handlers[key] as? T
    }
    
    public func getAllHandlers() -> [any DeepLinkHandler] {
        Array(handlers.values)
    }
    
    public func clear() {
        handlers.removeAll()
    }
}

// MARK: - DeepLink Handler Factory Protocol
public protocol DeepLinkHandlerFactory {
    func register<T: DeepLinkHandler>(_ handler: T)
    func unregister<T: DeepLinkHandler>(_ handler: T)
    func getHandler<T: DeepLinkHandler>(for type: T.Type) -> T?
    func getAllHandlers() -> [any DeepLinkHandler]
}
