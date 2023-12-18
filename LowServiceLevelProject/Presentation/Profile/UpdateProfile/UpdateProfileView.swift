//
//  UpdateProfileView.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/12.
//

import SwiftUI

struct UpdateProfileView: View {
    
    @StateObject var viewModel: UpdateProfileViewModel
    @State var showImagePicker: Bool = false
    
    var profileImage: Image {
        if let profileImageData = viewModel.profileImage {
            return Image(uiImage: (.init(data: profileImageData) ?? UIImage(systemName: "person"))!)
        } else {
            return Image(systemName: "person")
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 10) {
                Button(action: {
                    showImagePicker = true
                }, label: {
                    VStack {
                        profileImage
                            .resizable()
                            .scaledToFill()
                            .background(.gray)
                            .foregroundStyle(.white)
                            .clipShape(.circle)
                            .frame(width: 150, height: 150)
                            .toolbar {
                                ToolbarItem {
                                    Button("확인") {
                                        viewModel.editProfile()
                                    }
                                }
                        }
                        Text("이미지 크기: \(String(format: "%.2f", viewModel.profileImageSize))MB")
                        Text("프로필 이미지 크기는 1MB 이하의 사진만 가능합니다")
                            .font(.caption2)
                            .foregroundStyle(Color.gray)
                    }
                })
                TitleTextField(title: "닉네임", value: $viewModel.nick)
                TitleTextField(title: "전화번호", value: $viewModel.phoneNum ?? "")
                TitleTextField(title: "생년월일", value: $viewModel.birthDay ?? "")
            }
            .sheet(isPresented: $showImagePicker, content: {
                if #available(iOS 17.0, *) {
                    ImagePicker(selectImage: $viewModel.profileImage, currentError: $viewModel.currentError, imageSize: 150)
                } else {
                    VStack {
                        RoundedRectangle(cornerRadius: 8).fill(Color.gray)
                                        .frame(width: 60, height: 8)
                                        .padding(.top, 8)
                                        .padding(.bottom, 8)
                        ImagePicker(selectImage: $viewModel.profileImage, currentError: $viewModel.currentError, imageSize: 150)
                    }
                }
            })
        }
    }
}
