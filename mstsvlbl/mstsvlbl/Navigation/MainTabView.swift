//
//  MainTabView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            discoverTab
                .tabItem {
                    Label("Discover", systemImage: "sparkles")
                }
                .tag(0)

            quizzesTab
                .tabItem {
                    Label("Quizzes", systemImage: "list.bullet.rectangle")
                }
                .tag(1)

            bookmarksTab
                .tabItem {
                    Label("Bookmarks", systemImage: "bookmark")
                }
                .tag(2)

            statsTab
                .tabItem {
                    Label("Stats", systemImage: "chart.bar")
                }
                .tag(3)

            profileTab
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag(4)

            settingsTab
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(5)
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
