//
//  NavigatorView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI
import Observation
import Combine

@MainActor
@Observable
final class Coordinator {
    fileprivate var path: [Page] = []
    fileprivate var sheet: Page?
    fileprivate var fullScreenCoverPage: Page?
    
    private let shouldDismissSubject = PassthroughSubject<Void, Never>()

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
    
    func dismiss() {
        print("\(Self.self )::\(#function)")
        shouldDismissSubject.send()
    }

    func pop() {
        if !path.isEmpty {
            _ = path.removeLast()
        }
    }

    func popToRoot() {
        path.removeAll()
    }
    
    fileprivate var shouldDismissPublisher: AnyPublisher<Void, Never> {
        shouldDismissSubject.eraseToAnyPublisher()
    }
}

// MARK: - RootnavigatorView
struct NavigatorView<Root: View>: View {
    @State private var coordinator = Coordinator()
    @ViewBuilder private var root: () -> Root
    @Environment(\.dismiss) private var dismiss
    
    init(root: @escaping () -> Root) {
        self.root = root
    }

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            root()
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            coordinator.dismissFullScreenCover()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                        }
                        .buttonStyle(.plain)
                    }
                }
        }
        .fullScreenCover(item: $coordinator.fullScreenCoverPage) { page in
            page()
        }
        .sheet(item: $coordinator.sheet) { sheet in
            sheet()
        }
        .environment(coordinator)
        .onReceive(coordinator.shouldDismissPublisher) {
            print("Did receive dismiss signal")
            dismiss()
        }
    }
}

// MARK: - Preview
#Preview {
    NavigatorView {
        Text("Hello, World!")
    }
}
