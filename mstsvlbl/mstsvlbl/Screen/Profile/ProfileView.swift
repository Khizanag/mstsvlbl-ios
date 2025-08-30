//
//  ProfileView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack(spacing: DesignBook.Spacing.lg) {
            Image(systemName: "person.circle")
                .font(DesignBook.Font.extraLargeTitle())
                .foregroundStyle(DesignBook.Color.Text.secondary)
            
            Text("Guest User")
                .font(DesignBook.Font.headline())
            
            Text("Sign in to sync your progress across devices.")
                .font(DesignBook.Font.subheadline())
                .foregroundStyle(DesignBook.Color.Text.secondary)
            
            Spacer()
        }
        .padding(16)
        .navigationTitle("Profile")
    }
}

#Preview {
    ProfileView()
}
 
