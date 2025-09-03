//
//  DiscoverDeepLinkSubscriber.swift
//  Mstsvlbl_Core_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Mstsvlbl_Core_DeepLinking
import SwiftUI
import UIKit

@MainActor
final class DiscoverDeepLinkSubscriber: DeepLinkSubscriber {
    var id: String { String(describing: type(of: self)) }
    let subscribedPath = "discover"
    
    func didReceiveDeepLink(_ deepLink: any DeepLink, context: DeepLinkContext) async {
        presentViewOnTop(DiscoverView())
    }
}
