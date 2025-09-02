//
//  Choice.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import Foundation

public struct Choice: Codable, Identifiable, Equatable {
    public let id: UUID
    public let text: String
    public let isCorrect: Bool
}
