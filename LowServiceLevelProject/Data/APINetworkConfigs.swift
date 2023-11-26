//
//  APINetworkConfigs.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/22.
//

import Foundation

enum APINetworkConfigs {
    static let registerConfig = NetworkConfiguration(baseURL: URL(string: APIKey.baseURL)!, header: ["SesacKey":APIKey.secretKey], queryParameter: [:])
}
