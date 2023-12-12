//
//  DIContainer.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/22.
//

import Foundation

class NetworkDIContainer: ObservableObject {
    lazy var defaultNetworkService: NetworkService = {
        return DefaultNetworkService(config: APINetworkConfigs.authoTestConfig)
    }()
    
    lazy var defaultDataTransferService: DataTransferService = {
        return DataTransferService(networkService: defaultNetworkService, defaultResponseHandler: CommonResponseErrorHandler())
    }()
}

class AppDIContainer: ObservableObject {
    let networkDIContainer = NetworkDIContainer()
    
    private func getLoginFlowUseCase() -> LoginFlowUseCase {
        return DefaultLoginFlowUseCase(loginRepository: getAuthRepository(), tokenRepository: getTokenRepository())
    }
    
    @MainActor 
    func getUserStateViewModel() -> UserStateViewModel {
        return .init(loginFlowUseCases: getLoginFlowUseCase())
    }
    
    func getAuthRepository() -> AuthorizationRepository {
        return DefaultAuthRepository(dataTransferService: networkDIContainer.defaultDataTransferService)
    }
    
    func getProfileRepository() -> ProfileRepository {
        return DefaultProfileRepository(dataTransferService: networkDIContainer.defaultDataTransferService)
    }
    
    func getTokenRepository() -> TokenRepository {
        return DefaultTokenRepository()
    }
}
