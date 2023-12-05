//
//  ProfileView.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/04.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var showOptionView: Bool = false
    
    var body: some View {
        NavigationStack {
            HStack {
                Image(systemName: "person")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .background(.gray)
                    .foregroundStyle(.white)
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(Color.green, lineWidth: 5)
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            NavigationLink(destination: OptionView()) {
                                Image(systemName: "gear")
                                    .foregroundStyle(Color.gray)
                            }
                        }
                    }
                
                VStack {
                    Text("1234")
                        .font(.title)
                }
            }
        }
        
        
    }
}

#Preview {
    ProfileView()
}
