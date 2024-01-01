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
    @State var selectedImage: [Data] = []
    
    var selectedImageLazyView: some View {
        ScrollView(.horizontal) {
            LazyHStack(content: {
                ForEach(0..<$viewModel.imageList.count, id: \.self) { imageNumber in
                    SelectImageView(imageData: $viewModel.imageList[imageNumber], imageIndex: imageNumber) { imageIndex in
                        viewModel.imageList.remove(at: imageIndex)
                    }
                }
            })
        }
        .scrollIndicators(.hidden)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
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
                        Spacer()
                    }
                    .ignoresSafeArea(.keyboard)
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Button {
                            showImagePicker = true
                        } label: {
                            Image(systemName: "camera")
                        }
                        .disabled(viewModel.imageList.count >= 5)
                        .padding()
                        Spacer()
                    }
                    .background(.white)
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
                        viewModel.postContent()
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
                ImagePicker(selectImage: $viewModel.imageList, currentError: $viewModel.currentError, imageSize: 150, standard: .height, selectionLimit: 5 - viewModel.imageList.count)
            } else {
                VStack {
                    RoundedRectangle(cornerRadius: 8).fill(Color.gray)
                        .frame(width: 60, height: 8)
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                    ImagePicker(selectImage: $viewModel.imageList, currentError: $viewModel.currentError, imageSize: 150, standard: .height, selectionLimit: 5 - viewModel.imageList.count)
                }
            }
        })
    }
}

#Preview {
    PostWriteView(isPresented: .constant(true))
}
