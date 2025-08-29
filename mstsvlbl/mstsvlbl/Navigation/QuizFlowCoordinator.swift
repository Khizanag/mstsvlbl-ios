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
    var fullScreenCoverPage: Page?

    func push(_ page: Page) {
        path.append(page)
    }

    func presentSheet(_ page: Page) {
        sheet = page
    }
    
    func fullScreenCover(_ page: Page) {
        fullScreenCoverPage = page
    }

    func dismissSheet() {
        sheet = nil
    }
    
    func dismissFullScreenCover() {
        fullScreenCoverPage = nil
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
