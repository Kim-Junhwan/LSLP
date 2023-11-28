//
//  LoadingView.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/27.
//

import SwiftUI

struct LoadingView: View {
    
    @Binding var isShow: Bool
    
    var body: some View {
        if isShow {
            ZStack {
                Color.gray
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(.blue)
            }
            .opacity(0.6)
        }
    }
}

#Preview {
    LoadingView(isShow: .constant(true))
}
