//
//  Choice.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import Foundation

struct Choice: Codable, Identifiable, Equatable {
    let id: UUID
    let text: String
    let isCorrect: Bool
}