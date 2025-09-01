//
//  ProfileView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI
import AuthenticationServices

struct ProfileView: View {
    @Injected private var auth: AuthService

    var body: some View {
        ScrollView {
            VStack(spacing: DesignBook.Spacing.lg) {
                        HeaderView(
            icon: "person.circle.fill",
            title: "Profile",
            subtitle: isSignedIn ? "Manage your account and preferences" : "Sign in to sync your progress"
        )
        .padding(.bottom, DesignBook.Spacing.lg)
                
                if isSignedIn {
                    signedInContent
                } else {
                    guestContent
                }
                
                Spacer()
            }
            .padding(DesignBook.Spacing.xl)
        }
        .navigationTitle("Profile")
    }
}

private extension ProfileView {
    var isSignedIn: Bool { auth.state == .signedIn }
    
    @ViewBuilder
    var signedInContent: some View {
        Text("Signed in")
            .font(DesignBook.Font.headline())
        
        Button("Sign Out") { [self] in auth.signOut() }
            .buttonStyle(.bordered)
    }
    
    @ViewBuilder
    var guestContent: some View {
        Text("Guest User")
            .font(DesignBook.Font.headline())

        Text("Sign in to sync your progress across devices.")
            .font(DesignBook.Font.subheadline())
            .foregroundStyle(DesignBook.Color.Text.secondary)

        loginButton
    }

    var loginButton: some View {
        signInWithAppleButton
            .frame(height: 50) // TODO: Consider adding height constants to DesignBook
            .clipShape(RoundedRectangle(cornerRadius: DesignBook.Radius.lg, style: .continuous))
            .padding(.horizontal, DesignBook.Spacing.xl)
    }

    private var signInWithAppleButton: some View {
        SignInWithAppleButtonView { [self] in
            auth.signInWithApple()
        }
        .frame(height: 50) // TODO: Consider adding height constants to DesignBook
        .clipShape(RoundedRectangle(cornerRadius: DesignBook.Radius.lg, style: .continuous))
    }
}

#Preview {
    ProfileView()
}
