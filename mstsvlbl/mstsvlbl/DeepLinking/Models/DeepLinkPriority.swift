//
//  DeepLinkPriority.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

// MARK: - DeepLink Priority
public enum DeepLinkPriority: Int, CaseIterable, Comparable {
    case critical = 0
    case high = 1
    case normal = 2
    case low = 3
    
    public static func < (lhs: DeepLinkPriority, rhs: DeepLinkPriority) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
