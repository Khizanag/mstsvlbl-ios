//
//  Question.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import Foundation

struct Question: Codable, Identifiable {
    let id: UUID
    let text: String
    let choices: [Choice]
}