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