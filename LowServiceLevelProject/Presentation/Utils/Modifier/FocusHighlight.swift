//
//  FocusHighlight.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/19.
//

import Foundation
import SwiftUI

struct FocusHighlightModifier: ViewModifier {
    
    @FocusState var isFocus: Bool
    
    func body(content: Content) -> some View {
        content
            .padding(10)
            .focused($isFocus, equals: true)
            .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(isFocus ? .black : .gray , style: StrokeStyle(lineWidth: 1.0)))
    }
    
}

extension View {
    func focusHightLight() -> some View {
        modifier(FocusHighlightModifier())
    }
}
