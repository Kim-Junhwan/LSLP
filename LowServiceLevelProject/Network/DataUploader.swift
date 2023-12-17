//
//  DataUploader.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/16.
//

import Foundation

protocol DataUploader {
    typealias identifierValue = String
    func settingHeader(identifier: String, request: URLRequest) -> URLRequest
    func createPostBody(identifier: String, bodyParameterData: [String: String], datas: [String:[Data]]) -> Data
}

extension DataUploader {
    func settingHeader(identifier: String, request: URLRequest) -> URLRequest {
        var copyReq = request
        let contentType = "multipart/form-data; boundary=\(identifier)"
        copyReq.addValue(contentType, forHTTPHeaderField: "Content-Type")
        return copyReq
    }
}
