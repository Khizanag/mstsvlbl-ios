//
//  DeepLink.swift
//  Mstsvlbl_Core_DeepLinking
//
//  Created by Giga Khizanishvili on 02.09.25.
//

import Foundation

public struct DeepLink: Hashable, Identifiable, Sendable {
    public let id = UUID().uuidString
    public let name: String
    public let parameters: [String: String]
    
    public init(name: String, parameters: [String: String]) {
        self.name = name
        self.parameters = parameters
    }
    
    // MARK: - Hashable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(parameters)
    }
    
    public static func == (lhs: DeepLink, rhs: DeepLink) -> Bool {
        lhs.name == rhs.name && lhs.parameters == rhs.parameters
    }
}
