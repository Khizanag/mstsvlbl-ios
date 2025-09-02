//
//  DeepLinkSubscriber.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

// MARK: - Deep Link Subscriber Protocol
public protocol DeepLinkSubscriber: Identifiable {
    var id: String { get }
    
    /// Check if this subscriber can handle the given deep link
    func canHandleDeepLink(_ deepLink: any DeepLink) -> Bool
    
    /// Called when a deep link is received
    func didReceiveDeepLink(_ deepLink: any DeepLink, context: DeepLinkContext)
}

// MARK: - Default Implementation
public extension DeepLinkSubscriber {
    func canHandleDeepLink(_ deepLink: any DeepLink) -> Bool {
        // Default implementation accepts all deep links
        return true
    }
    
    func didReceiveDeepLink(_ deepLink: any DeepLink, context: DeepLinkContext) {
        // Default implementation does nothing
    }
}
