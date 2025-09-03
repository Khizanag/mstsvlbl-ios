//
//  DeepLinkHandlerRegistrator.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 03.09.25.
//

import Mstsvlbl_Core_DeepLinking

@MainActor
public final class DeepLinkHandlerRegistrator {
    @Injected private var deepLinkManager: DeepLinkManager
    
    private let handlers: [any DeepLinkHandler] = [
         QuizDeepLinkHandler(),
         CategoryDeepLinkHandler(),
         ProfileDeepLinkHandler(),
         SettingsDeepLinkHandler(),
         StatsDeepLinkHandler(),
         DiscoverDeepLinkHandler(),
         BookmarksDeepLinkHandler(),
    ]
    
    public func registerAll() async {
        for handler in handlers {
            await deepLinkManager.register(handler)
        }
    }
}
