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
                        TitleTextField(title: "이메일", value: $viewModel.email) {
                            Button("중복 확인") {
                                viewModel.validateEmail()
                            }
                        }
                    }
                    TitleTextField(title: "비밀번호", value: $viewModel.password)
                    TitleTextField(title: "닉네임", value: $viewModel.nick)
                    TitleTextField(title: "핸드폰 번호", value: $viewModel.phone)
                    DatePicker("생일", selection: $viewModel.birthDay, displayedComponents: [.date])
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("회원가입") {
                            viewModel.regist()
                        }
                    }
                }
                .errorAlert(error: $viewModel.currentError)
                .alert(viewModel.currentAction?.title ?? "", isPresented: $viewModel.showAlert) {
                    Button("확인") {
                        if viewModel.successRegister {
                            dismiss()
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
