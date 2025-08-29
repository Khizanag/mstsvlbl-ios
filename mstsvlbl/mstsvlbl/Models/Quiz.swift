//
//  Quiz.swift
//  mstsvlbl
//
//  Created by Assistant on 29.08.25.
//

import Foundation

struct Quiz: Codable {
    let title: String
    let questions: [Question]
}