//
//  LoginView.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/18.
//

import SwiftUI

struct LoginView: View {
    
    @State var id: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack {
            TextField(text: $id, prompt: Text("아이디")) {
                
            }
            .padding(10)
            .focusHightLight()
            
            SecureField(text: $password, prompt: Text("비밀번호")) {}
                .padding(10)
                .focusHightLight()
        }
        
    }
}

#Preview {
    LoginView()
}
