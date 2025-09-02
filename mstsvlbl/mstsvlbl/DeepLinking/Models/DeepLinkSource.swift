//
//  DeepLinkSource.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

// MARK: - DeepLink Source
public enum DeepLinkSource: String, CaseIterable {
    case appLaunch = "app_launch"
    case universalLink = "universal_link"
    case customScheme = "custom_scheme"
    case pushNotification = "push_notification"
    case background = "background"
    case foreground = "foreground"
    
    public var displayName: String {
        switch self {
        case .appLaunch: "App Launch"
        case .universalLink: "Universal Link"
        case .customScheme: "Custom Scheme"
        case .pushNotification: "Push Notification"
        case .background: "Background"
        case .foreground: "Foreground"
        }
    }
}
