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
    
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid deep link URL"
        case .unsupportedScheme:
            return "Unsupported deep link scheme"
        case .invalidPath:
            return "Invalid deep link path"
        case .missingRequiredParameters:
            return "Missing required parameters for deep link"
        case .parsingFailed:
            return "Failed to parse deep link"
        case .routingFailed:
            return "Failed to route deep link"
        }
    }
}
