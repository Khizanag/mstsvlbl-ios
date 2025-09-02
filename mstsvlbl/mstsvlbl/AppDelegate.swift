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
    private var coordinator: Coordinator?
    private var deepLinkRegistrator: DeepLinkRegistrator?
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        print("🔗 AppDelegate: didFinishLaunchingWithOptions called")
        DIBootstrap.bootstrap()
        Task {
            await setupDeepLinking()
        }
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

private extension AppDelegate {
    func setupDeepLinking() async {
        coordinator = Coordinator()
        deepLinkRegistrator = DeepLinkRegistrator(
            deepLinkManager: deepLinkManager,
            subscriberFactories: createSubscriberFactories()
        )
        await deepLinkRegistrator?.registerAllSubscribers()
    }
    
    func setupUIWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let contentView = MainTabView()
        let hostingController = UIHostingController(rootView: contentView)
        window?.rootViewController = hostingController
        window?.makeKeyAndVisible()
    }
    
    func createSubscriberFactories() -> [() async -> any Mstsvlbl_Core_DeepLinking.DeepLinkSubscriber] {
        return [
            { [weak self] in
                guard let window = self?.window else { fatalError("Window not available") }
                return await Mstsvlbl_Core_DeepLinking.QuizDeepLinkSubscriber(navigationHandler: window, dataProvider: LocalQuizRepository())
            },
            { [weak self] in
                guard let window = self?.window else { fatalError("Window not available") }
                return await Mstsvlbl_Core_DeepLinking.CategoryDeepLinkSubscriber(navigationHandler: window)
            },
            { [weak self] in
                guard let window = self?.window else { fatalError("Window not available") }
                return await Mstsvlbl_Core_DeepLinking.ProfileDeepLinkSubscriber(navigationHandler: window)
            },
            { [weak self] in
                guard let window = self?.window else { fatalError("Window not available") }
                return await Mstsvlbl_Core_DeepLinking.SettingsDeepLinkSubscriber(navigationHandler: window)
            },
            { [weak self] in
                guard let window = self?.window else { fatalError("Window not available") }
                return await Mstsvlbl_Core_DeepLinking.StatsDeepLinkSubscriber(navigationHandler: window)
            },
            { [weak self] in
                guard let window = self?.window else { fatalError("Window not available") }
                return await Mstsvlbl_Core_DeepLinking.DiscoverDeepLinkSubscriber(navigationHandler: window)
            },
            { [weak self] in
                guard let window = self?.window else { fatalError("Window not available") }
                return await Mstsvlbl_Core_DeepLinking.BookmarksDeepLinkSubscriber(navigationHandler: window)
            }
        ]
    }
}
