//
//  QuizFlowCoordinator.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI
import Observation

@MainActor
@Observable
final class QuizFlowCoordinator {
    
    var path: [Page] = []
    var sheet: Page?

    func push(_ page: Page) {
        path.append(page)
    }

    func present(_ page: Page) {
        sheet = page
    }

    func dismissSheet() {
        sheet = nil
    }

    func pop() {
        if !path.isEmpty {
            _ = path.removeLast()
        }
    }

    func popToRoot() {
        path.removeAll()
    }
}
