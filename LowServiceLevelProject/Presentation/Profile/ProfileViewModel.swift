//
//  ProfileViewModel.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/04.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    @Published var currentError: Error?
    
    let repository: ProfileRepository
    
    init(repository: ProfileRepository) {
        self.repository = repository
    }
    
    func getMyProfile() {
        repository.getMyProfile { [weak self] result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                self?.currentError = failure
            }
        }
    }
    
}
