//
//  Quiz.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import Foundation

struct Quiz: Codable, Identifiable {
    var id: String { title }
    let title: String
    let description: String?
    let createdAt: String?
    let coverUrl: URL?
    let maxTimeSeconds: Int?
    let questions: [Question]
}

// MARK: - Equatable
extension Quiz: Equatable {
    static func == (lhs: Quiz, rhs: Quiz) -> Bool { 
        lhs.id == rhs.id 
    }
}

// MARK: - Hashable
extension Quiz: Hashable {
    func hash(into hasher: inout Hasher) { 
        hasher.combine(id) 
    }
}

#if DEBUG
// MARK: - Example
extension Quiz {
    static var example: Quiz {
        .init(
            title: "Example Quiz",
            description: "This is an example quiz.",
            createdAt: nil,
            coverUrl: nil,
            maxTimeSeconds: 300,
            questions: []
        )
    }
}
#endif
