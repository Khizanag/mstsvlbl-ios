//
//  NavigatorView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI
import Observation

@MainActor
@Observable
final class Coordinator {
    fileprivate var path: [Page] = []
    fileprivate var sheet: Page?
    fileprivate var fullScreenCoverPage: Page?

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

// MARK: - RootnavigatorView
struct NavigatorView<Root: View>: View {
    @State private var coordinator = Coordinator()
    @ViewBuilder private var root: () -> Root
    
    init(root: @escaping () -> Root) {
        self.root = root
    }

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            root()
        }
        .fullScreenCover(item: $coordinator.fullScreenCoverPage) { page in
            page()
        }
        .sheet(item: $coordinator.sheet) { sheet in
            sheet()
        }
        .environment(coordinator)
    }
}

// MARK: - Preview
#Preview {
    NavigatorView {
        Text("Hello, World!")
    }
}
