//
//  AuthTest.swift
//  LowServiceLevelProjectTests
//
//  Created by JunHwan Kim on 2023/11/22.
//

import Foundation
@testable import LowServiceLevelProject

let authTestConfig = NetworkConfiguration(baseURL: URL(string: APIKey.authTestURL)!, header: ["SesacKey":APIKey.secretKey], queryParameter: [:])
