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
                DesignBook.HeaderView(
                    icon: "chart.bar.fill",
                    title: "Your Progress",
                    subtitle: "Track your quiz performance and achievements"
                )
                
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
 
