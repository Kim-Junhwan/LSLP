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
                                    
                                }
                            }
                        }
                })
                TitleTextField(title: "닉네임", value: $viewModel.nick)
                TitleTextField(title: "전화번호", value: $viewModel.phoneNum ?? "")
                TitleTextField(title: "생년월일", value: $viewModel.birthDay ?? "")
            }
            .sheet(isPresented: $showImagePicker, content: {
                if #available(iOS 17.0, *) {
                    ImagePicker(selectImage: $viewModel.profileImage, currentError: $viewModel.currentError)
                } else {
                    VStack {
                        RoundedRectangle(cornerRadius: 8).fill(Color.gray)
                                        .frame(width: 60, height: 8)
                                        .padding(.top, 8)
                                        .padding(.bottom, 8)
                        ImagePicker(selectImage: $viewModel.profileImage, currentError: $viewModel.currentError)
                    }
                }
            })
        }
    }
}



#Preview {
    UpdateProfileView(viewModel: UpdateProfileViewModel(nick: ""))
}
