//
//  TitleTextField.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/13.
//

import SwiftUI

struct TitleTextField: View {
    
    let title: String
    @Binding var value: String
    @FocusState var isFocus: Bool
    
    var body: some View {
        VStack {
            Text(title)
            TextField(title, text: $value)
                .focusHightLight()
                .focused($isFocus, equals: true)
                .overlay(alignment: .trailing) {
                    Button(action: {
                        value.removeAll()
                    }, label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 20)
                            .background(isFocus ? Color.black : Color.gray)
                            .foregroundStyle(isFocus ? Color.gray : Color.white)
                            .clipShape(Circle())
                            .padding()
                    })
                }
                .clipped()
        }
    }
}
