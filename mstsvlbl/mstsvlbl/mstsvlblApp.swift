//
//  mstsvlblApp.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import SwiftUI

@main
struct mstsvlblApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .onOpenURL { url in
                    print("🔗 SwiftUI App: Received URL: \(url)")
                    Task {
                        await appDelegate.deepLinkManager.handle(url: url)
                    }
                }
                .onContinueUserActivity(NSUserActivityTypeBrowsingWeb) { userActivity in
                    print("🔗 SwiftUI App: Received user activity: \(userActivity)")
                    if let url = userActivity.webpageURL {
                        Task {
                            await appDelegate.deepLinkManager.handle(url: url)
                        }
                    }
                }
        }
    }
}
