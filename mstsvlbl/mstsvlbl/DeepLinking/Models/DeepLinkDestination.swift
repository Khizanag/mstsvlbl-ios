//
//  DeepLinkDestination.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

// MARK: - DeepLink Destination
public enum DeepLinkDestination {
    case quiz(id: String, action: String)
    case category(name: String)
    case profile(action: String)
    case settings(section: String)
    case discover(filter: String?, sort: String?)
    case bookmarks(filter: String?)
    case stats(period: String)
    case custom(path: String, parameters: [String: Any])
    
    public var displayName: String {
        switch self {
        case .quiz(let id, let action):
            return "Quiz \(id) - \(action)"
        case .category(let name):
            return "Category \(name)"
        case .profile(let action):
            return "Profile - \(action)"
        case .settings(let section):
            return "Settings - \(section)"
        case .discover(let filter, let sort): 
            var name = "Discover"
            if let filter = filter { 
                name += " (Filter: \(filter))" 
            }
            if let sort = sort { 
                name += " (Sort: \(sort))" 
            }
            return name
        case .bookmarks(let filter):
            var name = "Bookmarks"
            if let filter = filter { 
                name += " (Filter: \(filter))" 
            }
            return name
        case .stats(let period):
            return "Stats - \(period)"
        case .custom(let path, _):
            return "Custom - \(path)"
        }
    }
}
