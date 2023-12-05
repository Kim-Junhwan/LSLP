//
//  LoginView.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/18.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var vm: UserStateViewModel
    @State var email = ""
    @State var password = ""
    
    @FocusState private var isFocus: Bool
    @State private var presentRegisterView: Bool = false
    @State private var showErrorAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 20) {
                TextField("이메일", text: $email, prompt: Text("이메일"))
                    .focusHightLight()
                    .focused($isFocus)
                
                SecureField("비밀번호", text: $password, prompt: Text("비밀번호"))
                    .focusHightLight()
                    .focused($isFocus)
                Button("로그인") {
                    vm.signIn(email: email, password: password)
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
            .errorAlert(error: $vm.currentError, title: "")
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
