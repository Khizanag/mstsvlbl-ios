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
    
    public nonisolated init(navigationHandler: NavigationHandler) {
        self.navigationHandler = navigationHandler
    }
    
    public func didReceiveDeepLink(_ deepLink: any DeepLink, context: DeepLinkContext) async {
        print("🎯 CategoryDeepLinkSubscriber: Handling category deep link")
        
        await handleCategoryDeepLink(deepLink)
    }
    
    private func handleCategoryDeepLink(_ deepLink: any DeepLink) async {
        // This is a generic implementation that can be extended by the app
        print("🎯 CategoryDeepLinkSubscriber: Generic handling for category deep link")
    }
}
