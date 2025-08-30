//
//  mstsvlblApp.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI
import SwiftData
import AuthenticationServices

@main
struct mstsvlblApp: App {
    @State private var userStore = UserStore()
    @State private var auth = AuthService()
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(userStore)
                .environment(auth)
        }
    }
}
