//
//  CustomTextField.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/21.
//

import Foundation
import SwiftUI

struct CustomTextField: UIViewRepresentable {
    typealias UIViewType = UITextField
    
    @Binding var text: String
    @Binding var becomeFirstResponder: Bool
    
    func makeUIView(context: Context) -> UITextField {
        return UITextField()
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        if self.becomeFirstResponder {
            DispatchQueue.main.async {
                uiView.becomeFirstResponder()
                becomeFirstResponder = false
            }
        }
    }
}
