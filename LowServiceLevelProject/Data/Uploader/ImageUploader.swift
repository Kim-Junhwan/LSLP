//
//  ImageUploader.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/16.
//

import Foundation

struct ImageUploader: DataUploader {
    func convertDatas(identifier: String, datas: [String : [Data]]) -> Data {
        var convertData = NSMutableData()
        for data in datas {
            for detailData in data.value.enumerated() {
                convertData.appendString("--\(identifier)\r\n")
                convertData.appendString("Content-Disposition: form-data; name=\"\(data.key)\"; filename=\"\(data.key)\(detailData.offset).jpg\"\r\n")
                convertData.appendString("Content-Type: image/jpeg\r\n\r\n")
                convertData.append(detailData.element)
                convertData.appendString("\r\n")
                convertData.appendString("--\(identifier)--\r\n")
            }
        }
        return convertData as Data
    }
    
}

extension NSMutableData {
    func appendString(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}
