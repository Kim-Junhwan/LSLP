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
    
    @Published var currentError: Error?
    @Published var successLogin: Bool = false
    
    let repository: AuthorizationRepository = DefaultAuthRepository(dataTransferService: DataTransferService(networkService: DefaultNetworkService(config: APINetworkConfigs.authoTestConfig), defaultResponseHandler: CommonResponseErrorHandler()))
    
    func login() {
        repository.login(request: .init(email: id, password: "\(password)")) { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.successLogin = true
                }
            case .failure(let failure):
                DispatchQueue.main.async {
                    self.currentError = failure
                    self.successLogin = false
                }
            }
        }
    }
}
