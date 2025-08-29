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
    
    private let canBeDismissed: Bool
    
    init(
        canBeDismissed: Bool = true,
        root: @escaping () -> Root
    ) {
        self.canBeDismissed = canBeDismissed
        self.root = root
    }

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            if canBeDismissed {
                root()
                    .toolbar {
                        dismissToolbarItem
                    }
                    .onAppear {
                        print("Created navigation stack so it CAN be dismissed")
                    }
            } else {
                root()
                    .onAppear {
                        print("Created navigation stack so it can NOT be dismissed")
                    }
            }
        }
        .fullScreenCover(item: $coordinator.fullScreenCoverPage) { page in
            print("Wrapping in navigatorView")
            return page(wrappedInNavigatorView: true)
        }
        .sheet(item: $coordinator.sheet) { sheet in
            sheet()
        }
        .environment(coordinator)
        .onReceive(coordinator.shouldDismissPublisher) {
            dismiss()
        }
    }
}

// MARK: - Components
private extension NavigatorView {
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
