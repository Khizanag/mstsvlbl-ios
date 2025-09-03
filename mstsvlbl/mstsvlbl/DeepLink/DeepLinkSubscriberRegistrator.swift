//
//  DeepLinkSubscriberRegistrator.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 03.09.25.
//

import Mstsvlbl_Core_DeepLinking

@MainActor
public final class DeepLinkSubscriberRegistrator {
    @Injected private var deepLinkManager: DeepLinkManager
    
    private let subscribers: [any DeepLinkSubscriber] = [
         QuizDeepLinkSubscriber(),
         CategoryDeepLinkSubscriber(),
         ProfileDeepLinkSubscriber(),
         SettingsDeepLinkSubscriber(),
         StatsDeepLinkSubscriber(),
         DiscoverDeepLinkSubscriber(),
         BookmarksDeepLinkSubscriber(),
    ]
    
    public func registerAll() async {
        for subscriber in subscribers {
            await deepLinkManager.register(subscriber)
        }
    }
}
