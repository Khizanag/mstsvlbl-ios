//
//  ProfileView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigatorView {
            VStack(spacing: DesignBook.Spacing.lg) {
                Image(systemName: "person.circle")
                    .font(.system(size: 64))
                    .foregroundStyle(DesignBook.Color.textSecondary)

                Text("Guest User")
                    .font(DesignBook.Font.headline)

                Text("Sign in to sync your progress across devices.")
                    .font(DesignBook.Font.subheadline)
                    .foregroundStyle(DesignBook.Color.textSecondary)

                Spacer()
            }
            .padding(DesignBook.Layout.contentPadding)
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ProfileView()
}


