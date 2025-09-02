//
//  DeepLinkError.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

// MARK: - DeepLink Error
public enum DeepLinkError: LocalizedError {
    case invalidURL
    case unsupportedScheme
    case invalidPath
    case missingRequiredParameters
    case parsingFailed
    case routingFailed
    case unsupportedPath
    
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            "Invalid deep link URL"
        case .unsupportedScheme:
            "Unsupported deep link scheme"
        case .invalidPath:
            "Invalid deep link path"
        case .missingRequiredParameters:
            "Missing required parameters for deep link"
        case .parsingFailed:
            "Failed to parse deep link"
        case .routingFailed:
            "Failed to route deep link"
        case .unsupportedPath:
            "Unsupported deep link path"
        }
    }
}
