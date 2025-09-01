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
    
    init() {
        // Setup DI
        DIBootstrap.bootstrap()
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}
