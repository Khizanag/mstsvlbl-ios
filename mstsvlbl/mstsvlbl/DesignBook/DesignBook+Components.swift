//
//  DesignBook+Components.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI

// MARK: - Shared Components
extension DesignBook {
    struct HeaderView: View {
        let icon: String
        let title: String
        let subtitle: String
        
        var body: some View {
            VStack(spacing: DesignBook.Spacing.md) {
                Image(systemName: icon)
                    .font(.system(size: 60))
                    .foregroundStyle(DesignBook.Color.Text.primary)
                    .symbolRenderingMode(.hierarchical)
                
                Text(title)
                    .font(DesignBook.Font.largeTitle())
                    .fontWeight(.bold)
                
                Text(subtitle)
                    .font(DesignBook.Font.subheadline())
                    .foregroundStyle(DesignBook.Color.Text.secondary)
            }
            .padding(.bottom, DesignBook.Spacing.lg)
        }
    }
}
