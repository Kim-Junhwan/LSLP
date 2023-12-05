//
//  RegisterView.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/19.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel = RegisterViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack {
                        TextField("이메일", text: $viewModel.email, prompt: Text("이메일"))
                            .focusHightLight()
                        Button("중복 확인") {
                            viewModel.validateEmail()
                        }
                        .disabled(viewModel.email.isEmpty)
                        .errorAlert(error: $viewModel.currentError)
                        .alert(viewModel.currentAction?.title ?? "", isPresented: $viewModel.showAlert) {
                            Button("확인"){
                                if viewModel.successRegister {
                                    dismiss()
                                }
                            }
                        } message: {
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
                            viewModel.regist()
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
