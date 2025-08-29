//
//  Quiz.swift
//  mstsvlbl
//
//  Created by Assistant on 29.08.25.
//

import Foundation

struct Quiz: Codable, Identifiable {
    var id: String { title }
    let title: String
    let questions: [Question]
}