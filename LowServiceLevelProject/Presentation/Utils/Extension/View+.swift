//
//  View+.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/14.
//

import Foundation
import SwiftUI

extension Binding {
    
    static func ?? (optional: Binding<Value?>, defaultValue: Value) -> Self {
        Binding(
            get: { optional.wrappedValue ?? defaultValue },
            set: { optional.wrappedValue = $0 }
        )

    }
}
