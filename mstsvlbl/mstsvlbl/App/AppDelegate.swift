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

// MARK: - Private
private extension AppDelegate {
    func setupDeepLinking() {
        let deepLinkRegistrator = DeepLinkRegistrator(
            deepLinkManager: deepLinkManager
        )
        deepLinkRegistrator.register()
        self.deepLinkRegistrator = deepLinkRegistrator
    }
    
    func setupUIWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let contentView = MainTabView()
        let hostingController = UIHostingController(rootView: contentView)
        window?.rootViewController = hostingController
        window?.makeKeyAndVisible()
    }
}
