//
//  Quiz.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import Foundation

public struct Quiz: Codable, Identifiable {
    public var id: String { title }
    public let title: String
    public let description: String?
    public let createdAt: String?
    public let coverUrl: URL?
    public let maxTimeSeconds: Int?
    public let category: Category?
    public let questions: [Question]
}

// MARK: - Equatable
extension Quiz: Equatable {
    public static func == (lhs: Quiz, rhs: Quiz) -> Bool { 
        lhs.id == rhs.id 
    }
}

// MARK: - Hashable
extension Quiz: Hashable {
    public func hash(into hasher: inout Hasher) { 
        hasher.combine(id) 
    }
}

#if DEBUG
// MARK: - Example
extension Quiz {
    public static var example: Quiz {
        .init(
            title: "Example Quiz",
            description: "This is an example quiz.",
            createdAt: nil,
            coverUrl: nil,
            maxTimeSeconds: 300,
            category: .science,
            questions: []
        )
    }
}
#endif
