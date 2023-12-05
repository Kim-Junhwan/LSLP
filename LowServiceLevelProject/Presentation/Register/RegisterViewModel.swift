//
//  RegisterViewModel.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/05.
//

import Foundation
import SwiftUI

final class RegisterViewModel: ObservableObject {
    
    enum CurrentAction {
        case validateEmail
        case register
        
        var title: String {
            switch self {
            case .validateEmail:
                return "사용 가능한 이메일"
            case .register:
                return "가입 완료"
            }
        }
        
        var errorTitle: String {
            switch self {
            case .validateEmail:
                return "사용이 불가능한 이메일입니다"
            case .register:
                return "회원가입 실패"
            }
        }
    }
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var nick: String = ""
    @Published var phone: String = ""
    @Published var birthDay: Date = Date()
    
    @Published var isLoading: Bool = false
    
    @Published var currentAction: CurrentAction?
    @Published var showAlert: Bool = false
    @Published var currentError: Error?
    
    var successRegister: Bool = false
    
    let repository: AuthorizationRepository = DefaultAuthRepository(dataTransferService: DataTransferService(networkService: DefaultNetworkService(config: APINetworkConfigs.registerConfig), defaultResponseHandler: CommonResponseErrorHandler()))
    
    func regist() {
        repository.register(request: .init(email: email, password: password, nick: nick, phoneNumber: phone, birthDay: birthDay.description)) { [weak self] result in
            switch result {
            case .success(_):
                self?.changeShowAlert(true, action: .register)
            case .failure(let failure):
                self?.changeError(error: failure)
            }
        }
    }
    
    func validateEmail() {
        isLoading = true
        repository.validateEmail(request: .init(email: email)) { [weak self] result in
            switch result {
            case .success(_):
                self?.changeShowAlert(true, action: .validateEmail)
            case .failure(let failure):
                self?.changeError(error: failure)
            }
        }
    }
    
    private func changeShowAlert(_ bool: Bool, action: CurrentAction) {
        DispatchQueue.main.async {
            self.showAlert = bool
            self.currentAction = action
        }
    }
    
    private func changeError(error: Error) {
        DispatchQueue.main.async {
            self.currentError = error
        }
    }
}
