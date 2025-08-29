//
//  DesignBook+Font.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI

extension DesignBook {
    enum Font {
        static let largeTitle: SwiftUI.Font = .system(size: 34, weight: .bold, design: .default)
        static let title: SwiftUI.Font = .system(size: 28, weight: .semibold, design: .default)
        static let title2: SwiftUI.Font = .system(size: 22, weight: .semibold, design: .default)
        static let headline: SwiftUI.Font = .system(size: 17, weight: .semibold, design: .default)
        static let body: SwiftUI.Font = .system(size: 17, weight: .regular, design: .default)
        static let subheadline: SwiftUI.Font = .system(size: 15, weight: .regular, design: .default)
        static let footnote: SwiftUI.Font = .system(size: 13, weight: .regular, design: .default)
        static let caption: SwiftUI.Font = .system(size: 12, weight: .regular, design: .default)
    }
}
