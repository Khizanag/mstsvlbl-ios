//
//  SettingsDeepLinkSubscriber.swift
//  Mstsvlbl_Core_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Mstsvlbl_Core_DeepLinking

@MainActor
final class SettingsDeepLinkSubscriber: DeepLinkSubscriber {
    let subscribedPath = "settings"
    
    func didReceiveDeepLink(_ deepLink: any DeepLink, context: DeepLinkContext) async {
        presentViewOnTop(SettingsView())
    }
}
