//
//  DefaultProfileRepository.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/06.
//

import Foundation

final class DefaultProfileRepository {
    private let dataTransferService: DataTransferService<CommonResponseErrorHandler>
    
    init(dataTransferService: DataTransferService<CommonResponseErrorHandler>) {
        self.dataTransferService = dataTransferService
    }
    
}

extension DefaultProfileRepository: ProfileRepository {
    func getMyProfile(completion: @escaping (Result<MyProfile, Error>) -> Void) {
        dataTransferService.request(endpoint: ProfileEndpoints.getMyProfile(), endpointResponseHandler: TokenErrorHandler()) { result in
            switch result {
            case .success(let success):
                completion(.success(success.toDomain()))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func editMyProfile(completion: @escaping (Result<MyProfile, Error>) -> Void) {
        
    }
    
    
}
