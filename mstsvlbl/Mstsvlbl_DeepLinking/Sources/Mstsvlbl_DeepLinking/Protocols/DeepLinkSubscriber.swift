//
//  DeepLinkSubscriber.swift
//  Mstsvlbl_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

public protocol DeepLinkSubscriber: Identifiable {
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

// MARK: - Generic Deep Link Subscriber

public protocol GenericDeepLinkSubscriber: DeepLinkSubscriber {
    associatedtype NavigationHandler
    associatedtype DataProvider
    
    var navigationHandler: NavigationHandler { get }
    var dataProvider: DataProvider { get }
    
    nonisolated init(navigationHandler: NavigationHandler, dataProvider: DataProvider)
}

// MARK: - Navigation-Only Deep Link Subscriber

public protocol NavigationOnlyDeepLinkSubscriber: DeepLinkSubscriber {
    associatedtype NavigationHandler
    
    var navigationHandler: NavigationHandler { get }
    
    nonisolated init(navigationHandler: NavigationHandler)
}
