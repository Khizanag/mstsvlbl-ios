//
//  DesignBook+Font.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI

extension DesignBook {
    enum Font {
        case extraLargeTitle
        case largeTitle
        case title
        case title2
        case headline
        case body
        case subheadline
        case footnote
        case caption

        func callAsFunction() -> SwiftUI.Font {
            switch self {
            case .extraLargeTitle:
                .system(size: 64, weight: .regular, design: .default)
            case .largeTitle:
                .system(size: 34, weight: .bold, design: .default)
            case .title:
                .system(size: 28, weight: .semibold, design: .default)
            case .title2:
                .system(size: 22, weight: .semibold, design: .default)
            case .headline:
                .system(size: 17, weight: .semibold, design: .default)
            case .body:
                .system(size: 17, weight: .regular, design: .default)
            case .subheadline:
                .system(size: 15, weight: .regular, design: .default)
            case .footnote:
                .system(size: 13, weight: .regular, design: .default)
            case .caption:
                .system(size: 12, weight: .regular, design: .default)
            }
        }
    }
}
