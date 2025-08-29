//
//  User.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import Foundation

struct PlayRecord: Codable, Identifiable, Hashable {
    let id: UUID
    let quizId: String
    let date: Date
    let score: Int
    let total: Int
}

struct User: Codable, Hashable {
    var name: String
    var bookmarks: Set<String>
    var featured: [String]
    var history: [PlayRecord]
}