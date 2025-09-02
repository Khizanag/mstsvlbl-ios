//
//  DeepLinkPlatform.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

public enum DeepLinkPlatform: String, CaseIterable {
    case iOS = "ios"
    case macOS = "macos"
    case watchOS = "watchos"
    case tvOS = "tvos"
    
    public var displayName: String {
        switch self {
        case .iOS: "iOS"
        case .macOS: "macOS"
        case .watchOS: "watchOS"
        case .tvOS: "tvOS"
        }
    }
}
