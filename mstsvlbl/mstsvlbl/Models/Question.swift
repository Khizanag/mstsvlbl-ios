//
//  Question.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import Foundation

public struct Question: Codable, Identifiable {
    public let id: UUID
    public let text: String
    public let choices: [Choice]
}

// MARK: - Hashable
extension Question: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Equatable
extension Question: Equatable { }
