//
//  LoginView.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/18.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewModel = LoginViewModel()
    @FocusState private var isFocus: Bool
    @State private var presentRegisterView: Bool = false
    @State private var showErrorAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 20) {
                TextField("이메일", text: $viewModel.id, prompt: Text("이메일"))
                    .focusHightLight()
                    .focused($isFocus)
                
                SecureField("비밀번호", text: $viewModel.password, prompt: Text("비밀번호"))
                    .focusHightLight()
                    .focused($isFocus)
                Button("로그인") {
                    viewModel.login()
                }
                NavigationLink("회원가입") {
                    RegisterView()
                }
            }
            .frame(width: 250)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isFocus = false
                    }
                }
            }
            .errorAlert(error: $viewModel.currentError, title: "")
            .fullScreenCover(isPresented: $viewModel.successLogin, content: {
                TabBar()
            })
            .onAppear {
                do {
                    try KeychainService.shared.delete(key: KeychainAuthorizNameSpace.accesshToken)
                    try KeychainService.shared.delete(key: KeychainAuthorizNameSpace.refreshToken)
                } catch {
                    
                }
                
            }
        }
    }
}

#Preview {
    LoginView()
}
