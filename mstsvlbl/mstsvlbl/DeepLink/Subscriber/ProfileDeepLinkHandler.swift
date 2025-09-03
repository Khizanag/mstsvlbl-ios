//
//  ProfileDeepLinkHandler.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Mstsvlbl_Core_DeepLinking

@MainActor
final class ProfileDeepLinkHandler: DeepLinkHandler {
    let host = "profile"
    
    func handle(_ deepLink: DeepLink, context: DeepLinkContext) async {
        presentViewOnTop(ProfileView())
    }
}
