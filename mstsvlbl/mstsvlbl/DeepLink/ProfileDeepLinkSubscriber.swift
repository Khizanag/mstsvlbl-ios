//
//  ProfileDeepLinkSubscriber.swift
//  Mstsvlbl_Core_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Mstsvlbl_Core_DeepLinking
import SwiftUI
import UIKit

@MainActor
final class ProfileDeepLinkSubscriber: DeepLinkSubscriber {
    let id = "ProfileDeepLinkSubscriber"
    let subscribedPath = "profile"
    
    func didReceiveDeepLink(_ deepLink: any DeepLink, context: DeepLinkContext) async {
        presentViewOnTop(ProfileView())
    }
}
