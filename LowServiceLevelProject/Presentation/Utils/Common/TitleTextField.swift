//
//  TitleTextField.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/13.
//

import SwiftUI

struct TitleTextField<SideView: View>: View {
    
    let title: String
    @Binding var value: String
    @FocusState var isFocus: Bool
    var splitView: (() -> SideView)?
    
    init(title: String, value: Binding<String>, splitView: (() -> SideView)?) {
        self.title = title
        self._value = value
        self.splitView = splitView
    }
    
    init(title: String, value: Binding<String>) where SideView == EmptyView {
        self.init(title: title, value: value, splitView: nil)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            HStack {
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
                splitView?()
            }
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
    
}

#Preview {
    TitleTextField(title: "123", value: .constant("234"))
}
