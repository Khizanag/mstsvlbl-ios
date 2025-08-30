//
//  LoginView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 30.08.25.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @Environment(AuthService.self) private var auth

    var body: some View {
        VStack(spacing: DesignBook.Spacing.lg) {
            Spacer()

            VStack(spacing: DesignBook.Spacing.sm) {
                Image(systemName: "person.crop.circle.badge.checkmark")
                    .font(DesignBook.Font.extraLargeTitle())
                    .foregroundStyle(DesignBook.Color.Icon.primary)
                Text("Welcome to mstsvlbl")
                    .font(DesignBook.Font.title())
                Text("Sign in with Apple to sync your bookmarks and progress.")
                    .font(DesignBook.Font.subheadline())
                    .foregroundStyle(DesignBook.Color.Text.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
            }

            SignInWithAppleButtonView {
                auth.signInWithApple()
            }
                .frame(height: 50)
                .clipShape(RoundedRectangle(cornerRadius: DesignBook.Radius.lg, style: .continuous))
                .padding(.horizontal, 24)

            Spacer()
        }
        .padding(16)
        .background(DesignBook.Color.Background.muted)
        .navigationTitle("Sign In")
    }

    private var SignInWithAppleButton: some View { EmptyView() }
}

#if DEBUG
#Preview {
    LoginView()
        .environment(AuthService())
}
#endif


