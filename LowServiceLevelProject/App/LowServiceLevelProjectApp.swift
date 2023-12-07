//
//  LowServiceLevelProjectApp.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/18.
//

import SwiftUI

@main
struct LowServiceLevelProjectApp: App {
    
    @StateObject var userStateViewModel = UserStateViewModel()
    
    var body: some Scene {
        WindowGroup {
            VStack {
                ApplicationSwitcher()
            }
            .environmentObject(userStateViewModel)
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
