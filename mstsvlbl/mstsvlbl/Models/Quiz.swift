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