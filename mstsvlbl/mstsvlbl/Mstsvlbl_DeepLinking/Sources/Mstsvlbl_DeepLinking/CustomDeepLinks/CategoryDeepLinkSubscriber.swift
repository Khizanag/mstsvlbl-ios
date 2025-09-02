//
//  CategoryDeepLinkSubscriber.swift
//  Mstsvlbl_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

@MainActor
public final class CategoryDeepLinkSubscriber<NavigationHandler>: NavigationOnlyDeepLinkSubscriber {
    public let id = "CategoryDeepLinkSubscriber"
    public let subscribedPath = "category"
    
    public let navigationHandler: NavigationHandler
    
    public init(navigationHandler: NavigationHandler) async {
        self.navigationHandler = navigationHandler
    }
    
    public func didReceiveDeepLink(_ deepLink: any DeepLink, context: DeepLinkContext) async {
        print("🎯 CategoryDeepLinkSubscriber: Handling category deep link")
        
        await handleCategoryDeepLink(deepLink)
    }
    
    private func handleCategoryDeepLink(_ deepLink: any DeepLink) async {
        print("🎯 CategoryDeepLinkSubscriber: Processing category deep link with path: \(deepLink.path)")
        print("🎯 CategoryDeepLinkSubscriber: Parameters: \(deepLink.parameters)")
        print("🎯 CategoryDeepLinkSubscriber: Navigation handler: \(type(of: navigationHandler))")
    }
}
