//
//  ImageUploader.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/16.
//

import Foundation

struct ImageUploader: DataUploader {
    func createPostBody(identifier: String, bodyParameterData: [String : String], datas: [String : [Data]]) -> Data {
        let convertData = NSMutableData()
        for parameter in bodyParameterData {
            convertData.appendString("\r\n--\(identifier)\r\n")
            convertData.appendString("Content-Disposition: form-data; name=\"\(parameter.key)\"\r\n\r\n")
            convertData.appendString(parameter.value)
        }
        
        convertData.append(convertDatas(identifier: identifier, datas: datas))
        convertData.appendString("--\(identifier)--\r\n")
        return convertData as Data
    }
    
    func convertDatas(identifier: String, datas: [String : [Data]]) -> Data {
        let convertData = NSMutableData()
        for data in datas {
            for detailData in data.value {
                convertData.appendString("\r\n--\(identifier)\r\n")
                convertData.appendString("Content-Disposition: form-data; name=\"\(data.key)\"; filename=\"\(data.key)\(identifier).jpg\"\r\n")
                convertData.appendString("Content-Type: image/jpeg\r\n\r\n")
                convertData.append(detailData)
                convertData.appendString("\r\n")
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
