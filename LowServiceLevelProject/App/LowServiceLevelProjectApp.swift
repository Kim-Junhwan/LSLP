//
//  LowServiceLevelProjectApp.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/18.
//

import SwiftUI

@main
struct LowServiceLevelProjectApp: App {
    
    @StateObject var appDIContainer = AppDIContainer()
    
    var body: some Scene {
        WindowGroup {
            VStack {
                ApplicationSwitcher()
            }
            .environmentObject(appDIContainer.getUserStateViewModel())
            .environmentObject(appDIContainer)
        }
    }
}

struct ApplicationSwitcher: View {
    @EnvironmentObject var vm: UserStateViewModel
    var body: some View {
        currentView
        .alert(Text("로그인 세션 만료"), isPresented: $vm.refreshTokenExpireAlert, actions: {
            Button("확인") {
                vm.isLoggedIn = false
            }
        }, message: {
            Text("로그인 세션이 만료되었습니다. 다시 로그인해주십시오.")
        })
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
