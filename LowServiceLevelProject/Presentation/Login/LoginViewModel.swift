//
//  LoginViewModel.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/02.
//

import Foundation

final class LoginViewModel: ObservableObject {
    @Published var id: String = ""
    @Published var password: String = ""
    
    let repository: AuthorizationRepository = DefaultAuthRepository(dataTransferService: DataTransferService(networkService: DefaultNetworkService(config: APINetworkConfigs.authoTestConfig), defaultResponseHandler: CommonResponseErrorHandler()))
    
    func login() {
        repository.login(request: .init(email: id, password: "\(password)")) { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
