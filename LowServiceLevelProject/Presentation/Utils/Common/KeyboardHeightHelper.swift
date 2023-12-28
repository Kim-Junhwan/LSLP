//
//  KeyboardHeightHelper.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/28.
//

import UIKit
import Foundation

class KeyboardHeightHelper: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0
    
    init() {
        listenForKeyboardNotification()
    }
    
    private func listenForKeyboardNotification() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: .main) { notifi in
            guard let userInfo = notifi.userInfo, let keyboardRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            self.keyboardHeight = keyboardRect.height
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { notifi in
            self.keyboardHeight = 0
        }
    }
}
