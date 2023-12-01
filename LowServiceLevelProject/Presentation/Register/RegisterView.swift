//
//  RegisterView.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/19.
//

import SwiftUI

struct RegisterView: View {
    
    enum CurrentAlert {
        case validateEmail
        case register
        
        var title: String {
            switch self {
            case .validateEmail:
                return "사용 가능한 이메일"
            case .register:
                return "가입 완료"
            }
        }
        
        var errorTitle: String {
            switch self {
            case .validateEmail:
                return "사용이 불가능한 이메일입니다"
            case .register:
                return "회원가입 실패"
            }
        }
    }
    
    @StateObject var viewModel = RegisterViewModel()
    @State private var showErrorAlert = false
    @State private var showAlert = false
    
    @State private var currentAlert: CurrentAlert = .register
    @State private var currentError: Error?
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack {
                        TextField("이메일", text: $viewModel.email, prompt: Text("이메일"))
                            .focusHightLight()
                        Button("중복 확인") {
                            currentAlert = .validateEmail
                            viewModel.validateEmail { error in
                                if error != nil {
                                    self.currentError = error
                                    showErrorAlert = true
                                    return
                                }
                                showAlert = true
                            }
                        }
                        .disabled(viewModel.emailEmpty)
                        .alert(currentAlert.errorTitle, isPresented: $showErrorAlert) {
                            Button("확인"){}
                        } message: {
                            Text(currentError?.localizedDescription ?? "")
                        }
                        .alert(currentAlert.title, isPresented: $showAlert) {
                            Button("확인"){}
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
                            currentAlert = .register
                            viewModel.register { error in
                                if error != nil {
                                    self.currentError = error
                                    showErrorAlert = true
                                    return
                                }
                                showAlert = true
                            }
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
