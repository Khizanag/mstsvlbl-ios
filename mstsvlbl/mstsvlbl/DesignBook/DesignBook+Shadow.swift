//
//  DesignBook+Shadow.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI

// MARK: - Shadow
extension DesignBook {
    struct Shadow {
        let color: SwiftUI.Color
        let radius: CGFloat
        let x: CGFloat
        let y: CGFloat

        private init(color: SwiftUI.Color, radius: CGFloat, x: CGFloat, y: CGFloat) {
            self.color = color
            self.radius = radius
            self.x = x
            self.y = y
        }
    }
}

// MARK: - Presets
extension DesignBook.Shadow {
    static let s = DesignBook.Shadow(color: DesignBook.Color.surfaceShadow, radius: 4, x: 0, y: 2)
    static let m = DesignBook.Shadow(color: DesignBook.Color.surfaceShadow, radius: 8, x: 0, y: 4)
    static let l = DesignBook.Shadow(color: DesignBook.Color.surfaceShadow, radius: 16, x: 0, y: 8)
}

// MARK: - ShadowModifier
private struct ShadowModifier: ViewModifier {
    private let shadow: DesignBook.Shadow

    init(_ shadow: DesignBook.Shadow) {
        self.shadow = shadow
    }

    func body(content: Content) -> some View {
        content.shadow(
            color: shadow.color,
            radius: shadow.radius,
            x: shadow.x,
            y: shadow.y
        )
    }
}

// MARK: - View Extension
extension View {
    func shadow(_ shadow: DesignBook.Shadow) -> some View {
        modifier(ShadowModifier(shadow))
    }
}
