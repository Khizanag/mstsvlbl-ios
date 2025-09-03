//
//  SettingsDeepLinkHandler.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Mstsvlbl_Core_DeepLinking

@MainActor
final class SettingsDeepLinkHandler: DeepLinkHandler {
    typealias Parameters = Never

    let host = "settings"
    
    func handle(_ parameters: [String: String], context: DeepLinkContext) async -> DeepLinkResult {
        presentViewOnTop(SettingsView())
        return .success
    }
}
