//
//  PostListView.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/19.
//

import SwiftUI

struct PostListView: View {
    
    @State private var showWriteCommentView: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        showWriteCommentView = true
                    }, label: {
                        Circle()
                            .frame(width: 50, height: 50)
                            .overlay {
                                Image(systemName: "pencil")
                                    .foregroundStyle(.white)
                            }
                    })
                    .padding()
                }
            }
            .fullScreenCover(isPresented: $showWriteCommentView, content: {
                PostWriteView(isPresented: $showWriteCommentView)
            })
        }
    }
}

#Preview {
    PostListView()
}
