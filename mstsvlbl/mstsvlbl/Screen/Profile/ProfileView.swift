//
//  ProfileView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI
import AuthenticationServices

struct ProfileView: View {
    @Environment(AuthService.self) private var auth

    var body: some View {
        VStack(spacing: DesignBook.Spacing.lg) {
            Image(systemName: "person.circle")
                .font(DesignBook.Font.extraLargeTitle())
                .foregroundStyle(DesignBook.Color.Text.secondary)
            
            if isSignedIn {
                Text("Signed in")
                    .font(DesignBook.Font.headline())
                Button("Sign Out") { auth.signOut() }
                    .buttonStyle(.bordered)
            } else {
                Text("Guest User")
                    .font(DesignBook.Font.headline())

                Text("Sign in to sync your progress across devices.")
                    .font(DesignBook.Font.subheadline())
                    .foregroundStyle(DesignBook.Color.Text.secondary)

                LoginButtons
            }
            
            Spacer()
        }
        .padding(16)
        .navigationTitle("Profile")
    }
}

private extension ProfileView {
    var isSignedIn: Bool { auth.state == .signedIn }

    var LoginButtons: some View {
        VStack(spacing: DesignBook.Spacing.sm) {
            SignInWithAppleButton
                .frame(height: 50)
                .clipShape(RoundedRectangle(cornerRadius: DesignBook.Radius.lg, style: .continuous))

            Button("Maybe later") {}
                .buttonStyle(.plain)
                .foregroundStyle(DesignBook.Color.Text.secondary)
        }
        .padding(.horizontal, 24)
    }

    private var SignInWithAppleButton: some View {
        SignInWithAppleButtonView {
            auth.signInWithApple()
        }
        .frame(height: 50)
        .clipShape(RoundedRectangle(cornerRadius: DesignBook.Radius.lg, style: .continuous))
    }
}

#Preview {
    ProfileView()
}
 
