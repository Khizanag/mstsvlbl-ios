//
//  AppDelegate.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import UIKit
import SwiftUI

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
        
        // Setup DI
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
        print("🔗 AppDelegate: openUrl called with: \(url)")
        Task {
            await deepLinkManager.handle(url: url)
        }
        return true
    }
    
    func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        print("🔗 AppDelegate: continue userActivity called with: \(userActivity)")
        if let url = userActivity.webpageURL {
            Task {
                await deepLinkManager.handle(url: url)
            }
            return true
        }
        return false
    }
}

// MARK: - Private Methods
private extension AppDelegate {
    func setupDeepLinking() {
        coordinator = Coordinator()
        
        deepLinkRegistrator = DeepLinkRegistrator(
            deepLinkManager: deepLinkManager,
            coordinator: coordinator!
        )
        
        // Register all subscribers through the registrator
        deepLinkRegistrator?.registerAllSubscribers()
    }
    
    func setupUIWindow() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let contentView = MainTabView()
        window.rootViewController = UIHostingController(rootView: contentView)
        self.window = window
        window.makeKeyAndVisible()
    }
}
