//
//  StatsDeepLinkSubscriber.swift
//  Mstsvlbl_Core_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Mstsvlbl_Core_DeepLinking

@MainActor
final class StatsDeepLinkSubscriber: DeepLinkSubscriber {
    let subscribedPath = "stats"
    
    func didReceiveDeepLink(_ deepLink: DeepLink, context: DeepLinkContext) async {
        presentViewOnTop(StatsView())
    }
}
