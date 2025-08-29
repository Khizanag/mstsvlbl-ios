//
//  RootNavigatorView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI
import Observation

struct RootNavigatorView: View {
    @State private var coordinator = QuizFlowCoordinator()

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            QuizListView()
                .environment(coordinator)
                .navigationDestination(for: Page.self) { page in
                    page()
                        .environment(coordinator)
                }
        }
        .sheet(item: $coordinator.sheet) { sheet in
            switch sheet {
            case .play:
                NavigationStack { sheet().environment(coordinator) }
                    .presentationDetents([])
                    .presentationDragIndicator(.hidden)
            default:
                sheet().environment(coordinator)
            }
        }
    }
}

#Preview {
    RootNavigatorView()
}
