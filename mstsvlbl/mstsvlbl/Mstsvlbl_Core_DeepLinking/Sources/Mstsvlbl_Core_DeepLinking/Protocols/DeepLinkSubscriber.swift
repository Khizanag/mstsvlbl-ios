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
    func canHandleDeepLink(_ deepLink: any DeepLink) -> Bool
    func didReceiveDeepLink(_ deepLink: any DeepLink, context: DeepLinkContext) async
}

public extension DeepLinkSubscriber {
    func canHandleDeepLink(_ deepLink: any DeepLink) -> Bool {
        deepLink.path.lowercased() == subscribedPath.lowercased()
    }
}
