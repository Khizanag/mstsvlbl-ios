//
//  DeepLinkDestination.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

public enum DeepLinkDestination: Equatable {
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

// MARK: - Equatable
extension DeepLinkDestination {
    public static func == (lhs: DeepLinkDestination, rhs: DeepLinkDestination) -> Bool {
        switch (lhs, rhs) {
        case (.quiz(let lhsId, let lhsAction), .quiz(let rhsId, let rhsAction)):
            return lhsId == rhsId && lhsAction == rhsAction
        case (.category(let lhsName), .category(let rhsName)):
            return lhsName == rhsName
        case (.profile(let lhsAction), .profile(let rhsAction)):
            return lhsAction == rhsAction
        case (.settings(let lhsSection), .settings(let rhsSection)):
            return lhsSection == rhsSection
        case (.discover(let lhsFilter, let lhsSort), .discover(let rhsFilter, let rhsSort)):
            return lhsFilter == rhsFilter && lhsSort == rhsSort
        case (.bookmarks(let lhsFilter), .bookmarks(let rhsFilter)):
            return lhsFilter == rhsFilter
        case (.stats(let lhsPeriod), .stats(let rhsPeriod)):
            return lhsPeriod == rhsPeriod
        case (.custom(let lhsPath, let lhsParams), .custom(let rhsPath, let rhsParams)):
            // For custom parameters, we'll compare the path and check if parameters have the same keys
            // This is a simplified comparison since [String: Any] doesn't conform to Equatable
            return lhsPath == rhsPath && lhsParams.keys.sorted() == rhsParams.keys.sorted()
        default:
            return false
        }
    }
}
