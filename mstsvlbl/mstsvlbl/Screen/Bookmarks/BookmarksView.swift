//
//  BookmarksView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI

struct BookmarksView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: DesignBook.Spacing.lg) {
                Image(systemName: "bookmark")
                    .font(.system(size: 48))
                    .foregroundStyle(DesignBook.Color.textSecondary)
                Text("No bookmarks yet")
                    .font(DesignBook.Font.headline)
                Text("Save your favorite quizzes to find them quickly.")
                    .font(DesignBook.Font.subheadline)
                    .foregroundStyle(DesignBook.Color.textSecondary)
                Spacer()
            }
            .padding(DesignBook.Layout.contentPadding)
            .navigationTitle("Bookmarks")
        }
    }
}

#Preview {
    BookmarksView()
}


