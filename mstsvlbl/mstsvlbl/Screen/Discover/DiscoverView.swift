//
//  DiscoverView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI

struct DiscoverView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: DesignBook.Spacing.lg) {
            Text("Featured Quizzes")
                .font(DesignBook.Font.title2())
            
            Text("Handpicked collections to get you started.")
                .font(DesignBook.Font.subheadline())
                .foregroundStyle(DesignBook.Color.Text.secondary)
            
            Spacer()
        }
        .padding(16)
        .navigationTitle("Discover")
    }
}

#Preview {
    DiscoverView()
}
 
