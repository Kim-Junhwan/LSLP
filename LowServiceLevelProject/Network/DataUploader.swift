//
//  DataUploader.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/16.
//

import Foundation

protocol DataUploader {
    typealias identifierValue = String
    func settingEndpoint(identifier: String, request: Requestable) -> Requestable
    func convertDatas(identifier: String ,datas: [String:[Data]]) -> Data
}

extension DataUploader {
    func settingEndpoint(identifier: String, request: Requestable) -> Requestable {
        var copyReq = request
        let contentType = "multipart/form-data; boundary=\(identifier)"
        copyReq.headerParameter["Content-Type"] = contentType
        return copyReq
    }
}
