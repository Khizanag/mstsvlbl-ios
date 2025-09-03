//
//  AppDelegate.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import UIKit
import SwiftUI
import Mstsvlbl_Core_DeepLinking

final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let deepLinkManager = DeepLinkManager()
    private var deepLinkRegistrator: DeepLinkRegistrator?
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        print("🔗 AppDelegate: didFinishLaunchingWithOptions called")
        DIBootstrap.bootstrap()
        setupDeepLinking()
        setupUIWindow()
        return true
    }
    
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        print("🔗 AppDelegate: open URL called with: \(url)")
        Task { await deepLinkManager.handle(url: url) }
        return true
    }
    
    func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        print("🔗 AppDelegate: continue userActivity called")
        if let url = userActivity.webpageURL {
            Task { await deepLinkManager.handle(url: url) }
        }
        return true
    }
}

// MARK: - DeepLinking
private extension AppDelegate {
    func setupDeepLinking() {
        deepLinkRegistrator = DeepLinkRegistrator(
            deepLinkManager: deepLinkManager,
            subscriberFactories: makeSubscriberFactories()
        )
        deepLinkRegistrator?.registerAllSubscribers()
    }
    
    func setupUIWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let contentView = MainTabView()
        let hostingController = UIHostingController(rootView: contentView)
        window?.rootViewController = hostingController
        window?.makeKeyAndVisible()
    }
    
    func makeSubscriberFactories() -> [() -> any DeepLinkSubscriber] {
        [
            { QuizDeepLinkSubscriber() },
            { CategoryDeepLinkSubscriber() },
            { ProfileDeepLinkSubscriber() },
            { SettingsDeepLinkSubscriber() },
            { StatsDeepLinkSubscriber() },
            { DiscoverDeepLinkSubscriber() },
            { BookmarksDeepLinkSubscriber() },
        ]
    }
}
