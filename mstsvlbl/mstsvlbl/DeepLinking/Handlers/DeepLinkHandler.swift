//
//  DeepLinkHandler.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

// MARK: - DeepLink Handler Protocol
public protocol DeepLinkHandler: AnyObject {
    associatedtype LinkType: DeepLink
    var metadata: DeepLinkMetadata { get }
    var isEnabled: Bool { get set }
    
    func canHandle(_ deepLink: any DeepLink) -> Bool
    func handle(_ deepLink: LinkType, context: DeepLinkContext) async -> DeepLinkResult
    func validate(_ deepLink: LinkType) -> DeepLinkError?
    func preprocess(_ deepLink: LinkType, context: DeepLinkContext) async -> DeepLinkContext
}

// MARK: - DeepLink Handler Default Implementation
public extension DeepLinkHandler {
    var isEnabled: Bool {
        get { true }
        set { }
    }
    
    func canHandle(_ deepLink: any DeepLink) -> Bool {
        deepLink is LinkType
    }
    
    func validate(_ deepLink: LinkType) -> DeepLinkError? {
        nil
    }
    
    func preprocess(_ deepLink: LinkType, context: DeepLinkContext) async -> DeepLinkContext {
        context
    }
}
