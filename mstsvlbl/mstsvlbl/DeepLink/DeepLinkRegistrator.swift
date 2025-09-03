//
//  DeepLinkRegistrator.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 03.09.25.
//

import Mstsvlbl_Core_DeepLinking

@MainActor
public final class DeepLinkRegistrator {
    
    private let deepLinkManager: DeepLinkManager
    private let subscriberFactories: [() -> any DeepLinkSubscriber] = [
        { QuizDeepLinkSubscriber() },
        { CategoryDeepLinkSubscriber() },
        { ProfileDeepLinkSubscriber() },
        { SettingsDeepLinkSubscriber() },
        { StatsDeepLinkSubscriber() },
        { DiscoverDeepLinkSubscriber() },
        { BookmarksDeepLinkSubscriber() },
    ]
    
    public init(deepLinkManager: DeepLinkManager) {
        self.deepLinkManager = deepLinkManager
    }
    
    public func register() {
        for factory in subscriberFactories {
            let subscriber = factory()
            deepLinkManager.subscribe(subscriber)
        }
    }
}
