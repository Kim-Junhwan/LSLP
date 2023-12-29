//
//  PostWriteView.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/19.
//

import SwiftUI

struct PostWriteView: View {
    
    @StateObject var viewModel: PostWriteViewModel = .init()
    @FocusState private var isFocus: Bool
    @State private var showImagePicker: Bool = false
    @Binding var isPresented: Bool
    
    var selectedImageLazyView: some View {
        ScrollView(.horizontal) {
            LazyHStack(content: {
                ForEach(1...10, id: \.self) { count in
                    Text("Placeholder \(count)")
                }
            })
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    HStack (alignment: .top) {
                        Image(systemName: "person")
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 30, height: 30)
                            .padding(.top, 5)
                        Spacer(minLength: 20)
                        CustomTextView(text: $viewModel.content, placeholder: "무슨 일이 일어나고 있나요?", placeholderColor: .gray)
                            .frame(maxWidth: .infinity, minHeight: 30)
                            .fixedSize(horizontal: false, vertical: true)
                            .focused($isFocus)
                    }
                    .padding()
                    .navigationTitle("게시글 작성")
                    .navigationBarTitleDisplayMode(.inline)
                    selectedImageLazyView
                        .frame(height: 150)
                        .ignoresSafeArea(.keyboard)
                }
                Spacer()
                HStack {
                    Button {
                        showImagePicker = true
                    } label: {
                        Image(systemName: "camera")
                    }
                    .padding()
                    Spacer()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("취소") {
                        isPresented = false
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
        }
        .sheet(isPresented: $showImagePicker, content: {
            if #available(iOS 17.0, *) {
                ImagePicker(selectImage: $viewModel.imageList, currentError: $viewModel.currentError, imageSize: 100)
            } else {
                VStack {
                    RoundedRectangle(cornerRadius: 8).fill(Color.gray)
                        .frame(width: 60, height: 8)
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                    ImagePicker(selectImage: $viewModel.imageList, currentError: $viewModel.currentError, imageSize: 100)
                }
            }
        })
    }
}

#Preview {
    PostWriteView(isPresented: .constant(true))
}
