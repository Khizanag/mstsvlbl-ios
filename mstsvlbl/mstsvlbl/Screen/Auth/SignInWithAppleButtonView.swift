//
//  SignInWithAppleButtonView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 30.08.25.
//

import SwiftUI
import AuthenticationServices

struct SignInWithAppleButtonView: View {
    let action: () -> Void

    var body: some View {
        PlatformButton(action: action)
    }
}

#if os(iOS)
import UIKit
private struct PlatformButton: UIViewRepresentable {
    let action: () -> Void

    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        let button = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
        button.addTarget(context.coordinator, action: #selector(Coordinator.tap), for: .touchUpInside)
        return button
    }

    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {}

    func makeCoordinator() -> Coordinator { Coordinator(action: action) }

    final class Coordinator: NSObject {
        private let action: () -> Void
        init(action: @escaping () -> Void) { self.action = action }
        @objc func tap() { action() }
    }
}
#else
import AppKit
private struct PlatformButton: NSViewRepresentable {
    let action: () -> Void

    func makeNSView(context: Context) -> ASAuthorizationAppleIDButton {
        let button = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .black)
        button.target = context.coordinator
        button.action = #selector(Coordinator.tap)
        return button
    }

    func updateNSView(_ nsView: ASAuthorizationAppleIDButton, context: Context) {}

    func makeCoordinator() -> Coordinator { Coordinator(action: action) }

    final class Coordinator: NSObject {
        private let action: () -> Void
        init(action: @escaping () -> Void) { self.action = action }
        @objc func tap() { action() }
    }
}
#endif


