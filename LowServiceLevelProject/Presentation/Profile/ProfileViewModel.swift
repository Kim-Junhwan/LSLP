//
//  ProfileViewModel.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/04.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    @Published var myProfile: MyProfile?
    @Published var currentError: Error?
    
    let repository: ProfileRepository
    
    init(repository: ProfileRepository) {
        self.repository = repository
    }
    
    func getMyProfile() {
        repository.getMyProfile { [weak self] result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self?.myProfile = success
                }
            case .failure(let failure):
                DispatchQueue.main.async {
                    self?.currentError = failure
                }
            }
        }
    }
    
}
