//
//  mstsvlblApp.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI
import SwiftData

@main
struct mstsvlblApp: App {
    @State private var userStore = UserStore()
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(userStore)
        }
    }
}
