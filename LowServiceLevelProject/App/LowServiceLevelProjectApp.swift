//
//  LowServiceLevelProjectApp.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/18.
//

import SwiftUI

@main
struct LowServiceLevelProjectApp: App {
    
    @StateObject var networkDiContainer = NetworkDIContainer()
    @StateObject var userStateViewModel = UserStateViewModel()
    
    var body: some Scene {
        WindowGroup {
            VStack {
                ApplicationSwitcher()
            }
            .alert(Text("로그인 세션 만료"), isPresented: $userStateViewModel.refreshTokenExpireAlert, actions: {
                Button("확인") {
                    userStateViewModel.isLoggedIn = false
                }
            }, message: {
                Text("로그인 세션이 만료되었습니다. 다시 로그인해주십시오.")
            })
            .environmentObject(userStateViewModel)
            .environmentObject(networkDiContainer)
        }
    }
}

struct ApplicationSwitcher: View {
    @EnvironmentObject var vm: UserStateViewModel
    var body: some View {
        currentView
    }
    
    @ViewBuilder
    var currentView: some View {
        if vm.isLoggedIn {
            TabBar()
        } else {
            LoginView()
        }
    }
}
