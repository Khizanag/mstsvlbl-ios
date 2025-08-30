//
//  DesignBook+Animation.swift
//  mstsvlbl
//
//  Created by Giga Khizanishvili on 29.08.25.
//

import SwiftUI

extension DesignBook {
    enum Animation {
        case fast
        case normal
        
        func callAsFunction() -> SwiftUI.Animation {
            switch self {
            case .fast:
                .easeInOut(duration: Duration.fast)
            case .normal:
                .easeInOut(duration: Duration.normal)
            }
        }
    }
}
