//
//  LoginView.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/18.
//

import SwiftUI

struct LoginView: View {
    
    @State private var id: String = ""
    @State private var password: String = ""
    @FocusState private var isFocus: Bool
    @State private var presentRegisterView: Bool = false
    
    var body: some View {
            VStack(alignment: .center, spacing: 20) {
                TextField(text: $id, prompt: Text("아이디")) {
                    
                }
                .padding(10)
                .focusHightLight()
                .focused($isFocus)
                
                SecureField(text: $password, prompt: Text("비밀번호")) {}
                    .padding(10)
                    .focusHightLight()
                    .focused($isFocus)
                Button("로그인") {}
                Button("회원가입") {
                    presentRegisterView = true
                }
            }
            .fullScreenCover(isPresented: $presentRegisterView, content: {
                RegisterView()
            })
            .onAppear()
            .frame(width: 250)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isFocus = false
                    }
                }
            }
    }
}

#Preview {
    LoginView()
}
