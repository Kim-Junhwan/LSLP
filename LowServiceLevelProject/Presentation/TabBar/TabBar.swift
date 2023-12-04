//
//  TabBar.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/04.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            Text("안녕")
                .tabItem {
                    Image(systemName: "house")
                    Text("메인")
                }
            
            OptionView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("설정")
                }
        }
    }
}

#Preview {
    TabBar()
}
