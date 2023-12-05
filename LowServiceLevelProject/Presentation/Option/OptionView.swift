//
//  OptionView.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/04.
//

import SwiftUI

struct OptionView: View {
    
    @EnvironmentObject var vm: UserStateViewModel
    @State private var selectIndex: Int?
    @State private var showLogoutAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            List(selection: $selectIndex, content: {
                Button {
                    showLogoutAlert = true
                } label: {
                    Text("로그아웃")
                        .tint(Color.red)
                }
            })
            .navigationTitle("설정")
            .alert("로그아웃", isPresented: $showLogoutAlert) {
                Button("취소", role: .cancel) {}
                Button("로그아웃", role: .destructive){
                    vm.signOut()
                }
            } message: {
                Text("로그아웃 하시겠습니까?")
            }
        }
    }
}

#Preview {
    OptionView()
}
