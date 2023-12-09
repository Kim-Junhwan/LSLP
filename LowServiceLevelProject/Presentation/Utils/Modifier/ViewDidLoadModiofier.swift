//
//  ViewDidLoadModiofier.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/09.
//

import Foundation
import SwiftUI

struct ViewDidLoadModiofier: ViewModifier {
    @State private var viewDidLoad = false
    let action: (()-> Void)?
    
    func body(content: Content) -> some View {
        content.onAppear {
            if !viewDidLoad {
                viewDidLoad = true
                action?()
            }
        }
    }
}

extension View {
    func viewDidLoad(_ action: (()-> Void)?) -> some View {
        self.modifier(ViewDidLoadModiofier(action: action))
    }
}
