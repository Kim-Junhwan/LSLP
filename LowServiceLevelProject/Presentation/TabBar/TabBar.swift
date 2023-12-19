//
//  TabBar.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/04.
//

import SwiftUI

struct TabBar: View {
    
    @EnvironmentObject var appDIConatiner: AppDIContainer
    
    var body: some View {
        TabView {
            PostListView()
                .tabItem {
                    Image(systemName: "house")
                    Text("메인")
                }
            
            ProfileView(viewModel: .init(repository: appDIConatiner.getProfileRepository()))
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("설정")
                }
        }
    }
}
