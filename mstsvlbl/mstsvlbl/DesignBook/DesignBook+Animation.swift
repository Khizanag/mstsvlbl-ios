//
//  DesignBook+Animation.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI

extension DesignBook {
    enum Animation {
        static let fast: SwiftUI.Animation = .easeInOut(duration: Duration.fast)
        static let normal: SwiftUI.Animation = .easeInOut(duration: Duration.normal)
    }
}

