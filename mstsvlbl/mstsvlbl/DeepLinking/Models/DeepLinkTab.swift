//
//  DeepLinkTab.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

// MARK: - DeepLink Tab
public enum DeepLinkTab: String, CaseIterable {
    case discover = "discover"
    case list = "list"
    case bookmarks = "bookmarks"
    case stats = "stats"
    case profile = "profile"
    
    public var displayName: String {
        switch self {
        case .discover: return "Discover"
        case .list: return "List"
        case .bookmarks: return "Bookmarks"
        case .stats: return "Stats"
        case .profile: return "Profile"
        }
    }
    
    public var icon: String {
        switch self {
        case .discover: return "magnifyingglass"
        case .list: return "list.bullet"
        case .bookmarks: return "bookmark"
        case .stats: return "chart.bar"
        case .profile: return "person"
        }
    }
}
