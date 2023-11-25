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
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("이메일", text: $viewModel.email, prompt: Text("이메일"))
                        .focusHightLight()
                    Button("중복 확인") {
                        
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
                            viewModel.register()
                        }
                    }
                }
        }
    }
}

#Preview {
    RegisterView()
}
