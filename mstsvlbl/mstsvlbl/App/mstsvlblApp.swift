//
//  mstsvlblApp.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import SwiftUI
import Mstsvlbl_Core_DeepLinking

@main
struct mstsvlblApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    @Injected private var deepLinkManager: DeepLinkManager
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .onOpenURL { url in
                    Task {
                        await deepLinkManager.handle(url: url)
                    }
                }
                .onContinueUserActivity(NSUserActivityTypeBrowsingWeb) { userActivity in
                    if let url = userActivity.webpageURL {
                        Task {
                            await deepLinkManager.handle(universalLink: url)
                        }
                    }
                }
        }
    }
}
