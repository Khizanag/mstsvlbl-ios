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
    /*fileprivate*/ var path: [Page] = []
    fileprivate var sheet: Page?
    fileprivate var fullScreenCoverPage: Page?
    
    private let shouldDismissSubject = PassthroughSubject<Void, Never>()
    
    fileprivate init() { }

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
    @Environment(\.dismiss) private var dismiss
    @State private var coordinator = Coordinator()
    
    // MARK: - Properties
    @ViewBuilder private var root: () -> Root
    private let canBeDismissed: Bool
    
    // MARK: - Init
    init(
        canBeDismissed: Bool = true,
        root: @escaping () -> Root
    ) {
        self.canBeDismissed = canBeDismissed
        self.root = root
    }

    // MARK: - Body
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            rootContent
                .navigationDestination(for: Page.self) { page in
                    page()
                        .toolbar {
                            dismissToolbarItem
                        }
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    sheet()
                }
                .fullScreenCover(item: $coordinator.fullScreenCoverPage) { page in
                    page(wrappedInNavigatorView: true)
                }
                .onReceive(coordinator.shouldDismissPublisher) {
                    dismiss()
                }
                .environment(coordinator)
        }
        
    }
}

// MARK: - Components
private extension NavigatorView {
    @ViewBuilder
    var rootContent: some View {
        if canBeDismissed {
            root()
                .toolbar {
                    dismissToolbarItem
                }
        } else {
            root()
        }
    }
    
    var dismissToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                coordinator.dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
            }
            .buttonStyle(.plain)
        }
    }
}

// MARK: - Preview
#Preview {
    NavigatorView {
        Text("Hello, World!")
    }
}
