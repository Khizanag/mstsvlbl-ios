//
//  DeepLinkHandler.swift
//  Mstsvlbl_Core_DeepLinking
//
// Created by Giga Khizanishvili on 02.09.25.
//

public protocol DeepLinkHandler: Identifiable, Sendable {
    var id: String { get }
    var subscribedPath: String { get }
    func canHandleDeepLink(_ deepLink: DeepLink) -> Bool
    func handle(_ deepLink: DeepLink, context: DeepLinkContext) async
}

public extension DeepLinkHandler {
    var id: String { String(describing: type(of: self)) }
    
    func canHandleDeepLink(_ deepLink: DeepLink) -> Bool {
        deepLink.name.lowercased() == subscribedPath.lowercased()
    }
}
