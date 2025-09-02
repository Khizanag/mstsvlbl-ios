//
//  DeepLinkTab.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

public enum DeepLinkTab: String, CaseIterable {
    case discover = "discover"
    case list = "list"
    case bookmarks = "bookmarks"
    case stats = "stats"
    case profile = "profile"
    
    public var displayName: String {
        switch self {
        case .discover: "Discover"
        case .list: "List"
        case .bookmarks: "Bookmarks"
        case .stats: "Stats"
        case .profile: "Profile"
        }
    }
    
    public var icon: String {
        switch self {
        case .discover: "magnifyingglass"
        case .list: "list.bullet"
        case .bookmarks: "bookmark"
        case .stats: "chart.bar"
        case .profile: "person"
        }
    }
}
