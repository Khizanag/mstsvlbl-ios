//
//  MainTabView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI

struct MainTabView: View {
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
        NavigatorView(canBeDismissed: false) {
            QuizListView()
        }
    }

    var discoverTab: some View {
        NavigatorView(canBeDismissed: false) {
            DiscoverView()
        }
    }

    var bookmarksTab: some View {
        NavigatorView(canBeDismissed: false) {
            BookmarksView()
        }
    }

    var statsTab: some View {
        NavigatorView(canBeDismissed: false) {
            StatsView()
        }
    }

    var profileTab: some View {
        NavigatorView(canBeDismissed: false) {
            ProfileView()
        }
    }

    var settingsTab: some View {
        NavigatorView(canBeDismissed: false) {
            SettingsView()
        }
    }
}

// MARK: - Preview
#Preview {
    MainTabView()
}
