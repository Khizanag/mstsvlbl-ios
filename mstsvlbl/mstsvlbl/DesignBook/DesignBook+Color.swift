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
            static let primary: SwiftUI.Color = {
                #if os(macOS)
                SwiftUI.Color(NSColor.windowBackgroundColor)
                #else
                SwiftUI.Color(.systemBackground)
                #endif
            }()
            static let secondary: SwiftUI.Color = {
                #if os(macOS)
                SwiftUI.Color(NSColor.controlBackgroundColor)
                #else
                SwiftUI.Color(.secondarySystemBackground)
                #endif
            }()
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
        
        enum Category {
            static let science: SwiftUI.Color = .blue
            static let mathematics: SwiftUI.Color = .purple
            static let geography: SwiftUI.Color = .green
            static let history: SwiftUI.Color = .brown
            static let literature: SwiftUI.Color = .orange
            static let sports: SwiftUI.Color = .red
            static let entertainment: SwiftUI.Color = .pink
            static let technology: SwiftUI.Color = .cyan
            static let art: SwiftUI.Color = .mint
            static let music: SwiftUI.Color = .indigo
            static let food: SwiftUI.Color = .yellow
            static let travel: SwiftUI.Color = .teal
            static let business: SwiftUI.Color = .gray
            static let health: SwiftUI.Color = .green
            static let nature: SwiftUI.Color = .mint
            static let space: SwiftUI.Color = .purple
            static let politics: SwiftUI.Color = .blue
            static let fashion: SwiftUI.Color = .pink
            static let automotive: SwiftUI.Color = .red
            static let gaming: SwiftUI.Color = .orange
        }
        
        enum Generic {
            static let white: SwiftUI.Color = .white
            static let black: SwiftUI.Color = .black
            static let gray: SwiftUI.Color = .gray
            static let clear: SwiftUI.Color = .clear
        }
    }
}