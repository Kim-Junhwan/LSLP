//
//  PostWriteView.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/19.
//

import SwiftUI

struct PostWriteView: View {
    
    @FocusState private var isFocused: Bool
    @StateObject var viewModel: PostWriteViewModel = .init()
    
    var body: some View {
        NavigationStack {
            HStack {
                Image(systemName: "person")
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 30, height: 30)
                Spacer(minLength: 20)
                TextField("무슨 일이 일어나고 있나요?", text: $viewModel.content)
                    .frame(width: .infinity)
                    .focused($isFocused)
            }
            .padding()
            .navigationTitle("게시글 작성")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("취소") {
                        
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("게시하기") {
                        
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    .clipShape(Capsule())
                    .bold()
                }
            }
            Spacer()
        }
        .onAppear {
            isFocused = true
        }
    }
}

#Preview {
    PostWriteView()
}
