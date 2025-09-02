//
//  mstsvlblApp.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI
import SwiftData
import AuthenticationServices

@main
struct mstsvlblApp: App {

    private let deepLinkManager = DeepLinkManager()
    @StateObject private var navigationCoordinator = DeepLinkNavigationCoordinator()
    
    init() {
        // Setup DI
        DIBootstrap.bootstrap()
        
        // Setup Deep Linking
        setupDeepLinking()
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView(navigationCoordinator: navigationCoordinator)
                .onOpenURL { url in
                    Task {
                        await deepLinkManager.handle(url: url)
                    }
                }
        }
    }
    
    private func setupDeepLinking() {
        // Connect navigation coordinator
        deepLinkManager.setNavigationCoordinator(navigationCoordinator)
        
        // Register all deep link handlers
        let handlerRegistry = DeepLinkHandlerRegistry()
        
        // Register handlers
        handlerRegistry.register(CategoryDeepLinkHandler())
        handlerRegistry.register(QuizDeepLinkHandler())
        handlerRegistry.register(ProfileDeepLinkHandler())
        handlerRegistry.register(SettingsDeepLinkHandler())
        handlerRegistry.register(StatsDeepLinkHandler())
        handlerRegistry.register(CustomDeepLinkHandler())
        handlerRegistry.register(DiscoverDeepLinkHandler())
        handlerRegistry.register(BookmarksDeepLinkHandler())
        
        // Register handlers with the manager
        deepLinkManager.registerHandlers(from: handlerRegistry)
        
        // Setup routes
        let router = DeepLinkRouter()
        deepLinkManager.setRouter(router)
        
        // Setup analytics
        let analyticsService = DeepLinkAnalyticsService()
        deepLinkManager.setAnalyticsService(analyticsService)
    }
}
