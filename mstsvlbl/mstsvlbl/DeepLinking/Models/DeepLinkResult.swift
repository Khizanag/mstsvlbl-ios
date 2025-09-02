//
//  DeepLinkResult.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

// MARK: - DeepLink Result
public enum DeepLinkResult {
    case success(DeepLink)
    case failure(DeepLinkError)
    case ignored(DeepLink)
}

// MARK: - DeepLink Result Extensions
public extension DeepLinkResult {
    var isSuccess: Bool {
        switch self {
        case .success: return true
        case .failure, .ignored: return false
        }
    }
    
    var isFailure: Bool {
        switch self {
        case .failure: return true
        case .success, .ignored: return false
        }
    }
    
    var isIgnored: Bool {
        switch self {
        case .ignored: return true
        case .success, .failure: return false
        }
    }
    
    var error: DeepLinkError? {
        switch self {
        case .failure(let error): return error
        case .success, .ignored: return nil
        }
    }
    
    var deepLink: DeepLink? {
        switch self {
        case .success(let deepLink), .ignored(let deepLink): return deepLink
        case .failure: return nil
        }
    }
}
