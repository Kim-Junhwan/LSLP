//
//  RegisterView.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/19.
//

import SwiftUI

struct RegisterView: View {
    @State private var userProfile = UserProfile()
    @State private var showSheet = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("이메일", text: $userProfile.email, prompt: Text("이메일"))
                        .focusHightLight()
                    Button("중복 확인") {
                        
                    }
                }
                TextField("비밀번호", text: $userProfile.password, prompt: Text("비밀번호"))
                    .focusHightLight()
                TextField("닉네임", text: $userProfile.nickName, prompt: Text("닉네임"))
                    .focusHightLight()
                TextField("핸드폰 번호", text: $userProfile.phoneNumber, prompt: Text("핸드폰 번호"))
                    .focusHightLight()
                DatePicker("생일", selection: $userProfile.bitrhDay, displayedComponents: [.date])
            }
            .frame(width: 350)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("회원가입") {
                            
                        }
                    }
                }
        }
    }
}

#Preview {
    RegisterView()
}
