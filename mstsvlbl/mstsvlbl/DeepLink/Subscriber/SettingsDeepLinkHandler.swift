//
//  SettingsDeepLinkHandler.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Mstsvlbl_Core_DeepLinking

@MainActor
final class SettingsDeepLinkHandler: DeepLinkHandler {
    let host = "settings"
    
    func handle(_ deepLink: DeepLink, context: DeepLinkContext) async {
        presentViewOnTop(SettingsView())
    }
}
