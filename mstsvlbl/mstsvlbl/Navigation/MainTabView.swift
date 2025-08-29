//
//  MainTabView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI
import Observation

struct MainTabView: View {
    @State private var coordinator = QuizFlowCoordinator()

    var body: some View {
        TabView {
            discoverTab
                .tabItem {
                    Label("Discover", systemImage: "sparkles")
                }

            quizzesTab
                .tabItem {
                    Label("Quizzes", systemImage: "list.bullet.rectangle")
                }

            bookmarksTab
                .tabItem {
                    Label("Bookmarks", systemImage: "bookmark")
                }

            statsTab
                .tabItem {
                    Label("Stats", systemImage: "chart.bar")
                }

            profileTab
                .tabItem {
                    Label("Profile", systemImage: "person")
                }

            settingsTab
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

// MARK: - Tabs
private extension MainTabView {
    var quizzesTab: some View {
        RootNavigatorView()
            .environment(coordinator)
    }

    var discoverTab: some View {
        DiscoverView()
    }

    var bookmarksTab: some View {
        BookmarksView()
    }

    var statsTab: some View {
        StatsView()
    }

    var profileTab: some View {
        ProfileView()
    }

    var settingsTab: some View {
        SettingsView()
    }
}

// MARK: - Preview
#Preview {
    MainTabView()
}


