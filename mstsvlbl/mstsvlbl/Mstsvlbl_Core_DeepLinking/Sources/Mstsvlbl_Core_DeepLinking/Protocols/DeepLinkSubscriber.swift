//
//  DeepLinkSubscriber.swift
//  Mstsvlbl_Core_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

public protocol DeepLinkSubscriber: Identifiable, Sendable {
    var id: String { get }
    var subscribedPath: String { get }
    func canHandleDeepLink(_ deepLink: DeepLink) -> Bool
    func didReceiveDeepLink(_ deepLink: DeepLink, context: DeepLinkContext) async
}

public extension DeepLinkSubscriber {
    var id: String { String(describing: type(of: self)) }
    
    func canHandleDeepLink(_ deepLink: DeepLink) -> Bool {
        deepLink.name.lowercased() == subscribedPath.lowercased()
    }
}
