//
//  StatsView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI

struct StatsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: DesignBook.Spacing.lg) {
                        HeaderView(
            icon: "chart.bar.fill",
            title: "Your Progress",
            subtitle: "Track your quiz performance and achievements"
        )
        .padding(.bottom, DesignBook.Spacing.lg)
                
                VStack(spacing: DesignBook.Spacing.lg) {
                    Text("Coming soon…")
                        .font(DesignBook.Font.subheadline())
                        .foregroundStyle(DesignBook.Color.Text.secondary)
                        
                    Spacer()
                }
            }
            .padding(DesignBook.Spacing.xl)
        }
        .navigationTitle("Stats")
    }
}

// MARK: - Preview
#Preview {
    StatsView()
}
 
