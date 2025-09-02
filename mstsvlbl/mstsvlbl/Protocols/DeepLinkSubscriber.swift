//
//  DeepLinkSubscriber.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

// MARK: - Deep Link Subscriber Protocol
public protocol DeepLinkSubscriber: Identifiable {
    
    /// Unique identifier for the subscriber
    var id: String { get }
    
    /// The deep link path this subscriber is interested in
    var subscribedPath: String { get }
    
    /// Check if this subscriber can handle the given deep link
    func canHandleDeepLink(_ deepLink: any DeepLink) -> Bool
    
    /// Handle the received deep link - subscriber is responsible for its own navigation
    func didReceiveDeepLink(_ deepLink: any DeepLink, context: DeepLinkContext)
}

// MARK: - Default Implementation
public extension DeepLinkSubscriber {
    
    /// Default implementation: check if the deep link path matches the subscribed path
    func canHandleDeepLink(_ deepLink: any DeepLink) -> Bool {
        deepLink.path.lowercased() == subscribedPath.lowercased()
    }
}
