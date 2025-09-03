//
//  DeepLink.swift
//  Mstsvlbl_Core_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

public protocol DeepLink: Hashable, Identifiable, Sendable {
    var path: String { get }
    var parameters: [String: String] { get }
}

public struct AppDeepLink: DeepLink {
    public let id = UUID().uuidString
    public let path: String
    public let parameters: [String: String]
    
    public init(path: String, parameters: [String: String]) {
        self.path = path
        self.parameters = parameters
    }
    
    // MARK: - Hashable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(path)
        hasher.combine(parameters)
    }
    
    public static func == (lhs: AppDeepLink, rhs: AppDeepLink) -> Bool {
        lhs.path == rhs.path && lhs.parameters == rhs.parameters
    }
}
