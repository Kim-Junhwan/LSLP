//
//  ProfileView.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/04.
//

import SwiftUI

struct ProfileView: View {
    @State private var showOptionView: Bool = false
    @ObservedObject private var viewModel: ProfileViewModel
    @EnvironmentObject var diContainer: AppDIContainer
    
    let column: [GridItem] = [
        .init(.adaptive(minimum: 100))
    ]
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .background(.gray)
                        .foregroundStyle(.white)
                        .clipShape(Circle())
                        .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                Menu {
                                    NavigationLink {
                                        UpdateProfileView(viewModel: UpdateProfileViewModel(nick: viewModel.myProfile?.nick ?? ""))
                                    } label: {
                                        Text("프로필 수정")
                                    }
                                } label: {
                                    Image(systemName: "ellipsis")
                                        .foregroundStyle(.gray)
                                }
                                
                                
                            }
                            ToolbarItem(placement: .topBarTrailing) {
                                NavigationLink(destination: OptionView()) {
                                    Image(systemName: "gearshape.fill")
                                        .foregroundStyle(Color.gray)
                                }
                            }
                        }
                    Spacer()
                    HStack(alignment: .center, spacing: 40) {
                        VStack {
                            Text("\(viewModel.myProfile?.postsId.count ?? 0)")
                                .font(.title)
                            Text("게시글")
                        }
                        VStack {
                            Text("\(viewModel.myProfile?.following.count ?? 0)")
                                .font(.title)
                            Text("팔로잉")
                        }
                        VStack {
                            Text("\(viewModel.myProfile?.followers.count ?? 0)")
                                .font(.title)
                            Text("팔로워")
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                Text("\(viewModel.myProfile?.nick ?? "")")
                ScrollView {
                    LazyVGrid(columns: column) {
                        ForEach(viewModel.myProfile?.postsId ?? [], id: \.self) { i in
                            Text(i)
                        }
                        .padding()
                    }
                }
            }
            
            .padding()
        }
        .refreshable {
            viewModel.getMyProfile()
        }
        .viewDidLoad {
            viewModel.getMyProfile()
        }
        .errorAlert(error: $viewModel.currentError)
        
    }
}

class FakeProfileRepository: ProfileRepository {
    func getMyProfile(completion: @escaping (Result<MyProfile, Error>) -> Void) {}
    
    func editMyProfile(completion: @escaping (Result<MyProfile, Error>) -> Void) {}
}

#Preview {
    ProfileView(viewModel: ProfileViewModel(repository: FakeProfileRepository()))
}
