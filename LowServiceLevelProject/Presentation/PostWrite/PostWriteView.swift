//
//  PostWriteView.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/19.
//

import SwiftUI

struct PostWriteView: View {
    
    @State private var textFieldFirstResponder = true
    @StateObject var viewModel: PostWriteViewModel = .init()
    @FocusState private var isFocus: Bool
    
    var body: some View {
        NavigationStack {
            HStack(alignment: .top) {
                Image(systemName: "person")
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 30, height: 30)
                    .padding(.top, 5)
                Spacer(minLength: 20)
                CustomTextView(text: $viewModel.content, placeholder: "무슨 일이 일어나고 있나요?", placeholderColor: .gray)
                    .frame(minHeight: 30.0 ,maxHeight: .infinity)
                    .focused($isFocus)
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
            .onTapGesture {
                isFocus = false
            }
            Spacer()
        }
    }
}

#Preview {
    PostWriteView()
}
