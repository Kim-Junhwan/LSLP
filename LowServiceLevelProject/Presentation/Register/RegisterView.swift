//
//  RegisterView.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/19.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject var viewModel = RegisterViewModel()
    @State private var showSheet = false
    @State private var showErrorAlert = false
    @State private var showAlert = false
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack {
                        TextField("이메일", text: $viewModel.email, prompt: Text("이메일"))
                            .focusHightLight()
                        Button("중복 확인") {
                            viewModel.validateEmail { error in
                                if error != nil {
                                    showErrorAlert = true
                                    return
                                }
                                showAlert = true
                            }
                        }
                        .disabled(viewModel.emailEmpty)
                        .alert("에러", isPresented: $showErrorAlert) {
                            Button("확인"){}
                        } message: {
                            Text(viewModel.errorDescription)
                        }
                        .alert("사용가능한 이메일", isPresented: $showAlert) {
                            Button("확인"){}
                        }
                    }
                    TextField("비밀번호", text: $viewModel.password, prompt: Text("비밀번호"))
                        .focusHightLight()
                    TextField("닉네임", text: $viewModel.nick, prompt: Text("닉네임"))
                        .focusHightLight()
                    TextField("핸드폰 번호", text: $viewModel.phone, prompt: Text("핸드폰 번호"))
                        .focusHightLight()
                    DatePicker("생일", selection: $viewModel.birthDay, displayedComponents: [.date])
                }
                .frame(width: 350)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("회원가입") {
                            //viewModel.register()
                        }
                    }
                }
                LoadingView(isShow: $viewModel.isLoading)
                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    RegisterView()
}
