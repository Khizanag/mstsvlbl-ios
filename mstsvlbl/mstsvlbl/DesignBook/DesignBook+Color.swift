//
//  DesignBook+Color.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI

extension DesignBook {
    enum Color {
        enum Brand {
            static let primary: SwiftUI.Color = .accentColor
        }

        enum Text {
            static let primary: SwiftUI.Color = .primary
            static let secondary: SwiftUI.Color = .secondary
        }

        enum Background {
            static let muted: SwiftUI.Color = .gray.opacity(0.08)
        }

        enum Border {
            static let `default`: SwiftUI.Color = .gray.opacity(0.15)
        }

        enum Overlay {
            static let shadow: SwiftUI.Color = .black.opacity(0.05)
        }

        enum Interaction {
            static let correct: SwiftUI.Color = .green.opacity(0.25)
            static let correctFaint: SwiftUI.Color = .green.opacity(0.15)
            static let incorrect: SwiftUI.Color = .red.opacity(0.25)
            static let optionIdle: SwiftUI.Color = .gray.opacity(0.1)
        }

        enum Icon {
            static let primary: SwiftUI.Color = Text.primary
            static let secondary: SwiftUI.Color = Text.secondary
        }

        enum Status {
            static let success: SwiftUI.Color = .green
            static let warning: SwiftUI.Color = .orange
            static let error: SwiftUI.Color = .red
            static let info: SwiftUI.Color = .blue
        }
    }
}