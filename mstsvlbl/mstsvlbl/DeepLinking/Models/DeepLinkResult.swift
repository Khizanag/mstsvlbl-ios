//
//  DeepLinkResult.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

// MARK: - DeepLink Result
public enum DeepLinkResult {
    case success(any DeepLink)
    case failure(DeepLinkError)
    case ignored(any DeepLink)
}

// MARK: - DeepLink Result Extensions
public extension DeepLinkResult {
    var isSuccess: Bool {
        switch self {
        case .success: true
        case .failure, .ignored: false
        }
    }
    
    var isFailure: Bool {
        switch self {
        case .failure: true
        case .success, .ignored: false
        }
    }
    
    var isIgnored: Bool {
        switch self {
        case .ignored: true
        case .success, .failure: false
        }
    }
    
    var error: DeepLinkError? {
        switch self {
        case .failure(let error): error
        case .success, .ignored: nil
        }
    }
    
    var deepLink: (any DeepLink)? {
        switch self {
        case .success(let deepLink), .ignored(let deepLink): deepLink
        case .failure: nil
        }
    }
}
