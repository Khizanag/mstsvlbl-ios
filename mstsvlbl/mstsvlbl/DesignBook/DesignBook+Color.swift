//
//  DesignBook+Color.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI

extension DesignBook {
    enum Color {
        static let brand: SwiftUI.Color = .accentColor
        static let textPrimary: SwiftUI.Color = .primary
        static let textSecondary: SwiftUI.Color = .secondary
        static let cardBorder: SwiftUI.Color = .gray.opacity(0.15)
        static let surfaceShadow: SwiftUI.Color = .black.opacity(0.05)
        static let mutedBackground: SwiftUI.Color = .gray.opacity(0.08)
        static let correct: SwiftUI.Color = .green.opacity(0.25)
        static let correctFaint: SwiftUI.Color = .green.opacity(0.15)
        static let incorrect: SwiftUI.Color = .red.opacity(0.25)
        static let optionIdle: SwiftUI.Color = .gray.opacity(0.1)
    }
}