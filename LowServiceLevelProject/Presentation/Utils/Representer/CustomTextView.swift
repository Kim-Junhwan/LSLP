//
//  CustomTextView.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/21.
//

import Foundation
import SwiftUI

struct CustomTextView: UIViewRepresentable {
    
    typealias UIViewType = UITextView
    
    @Binding var text: String
    
    var placeholder: String?
    var placeholderColor: UIColor = .gray
    var defaultFontSize: CGFloat = 20.0
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.sizeToFit()
        if let placeholder {
            textView.text = placeholder
            textView.textColor = placeholderColor
        }
        textView.font = .systemFont(ofSize: defaultFontSize)
        textView.delegate = context.coordinator
        textView.becomeFirstResponder()
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: CustomTextView
        
        init(parent: CustomTextView) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
            if textView.text.isEmpty {
                textView.textColor = parent.placeholderColor
            } else {
                textView.textColor = .black
            }
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == parent.placeholder {
                textView.text = ""
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = parent.placeholder
            }
        }
    }
}
