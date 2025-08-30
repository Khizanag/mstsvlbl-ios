//
//  StatsView.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI

struct StatsView: View {
    var body: some View {
        VStack(spacing: 16) {
                Text("Your Progress")
                    .font(DesignBook.Font.title2())
                Text("Coming soon…")
                    .font(DesignBook.Font.subheadline())
                    .foregroundStyle(DesignBook.Color.Text.secondary)
                Spacer()
            }
            .padding(16)
            .navigationTitle("Stats")
        }
}

#Preview {
    StatsView()
}
 
