//
//  DIContainer.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/22.
//

import Foundation

class NetworkDIContainer: ObservableObject {
    private lazy var defaultNetworkService: NetworkService = {
        return DefaultNetworkService(config: APINetworkConfigs.authoTestConfig)
    }()
    
    private lazy var defaultDataTransferService: DataTransferService = {
        return DataTransferService(networkService: defaultNetworkService, defaultResponseHandler: CommonResponseErrorHandler())
    }()
    
    func getAuthRepository() -> AuthorizationRepository {
        return DefaultAuthRepository(dataTransferService: defaultDataTransferService)
    }
    
    func getProfileRepository() -> ProfileRepository {
        return DefaultProfileRepository(dataTransferService: defaultDataTransferService)
    }
    
    func getTokenRepository() -> TokenRepository {
        return DefaultTokenRepository()
    }
}

class AppDIContainer: ObservableObject {
}
