//
//  Endpoint.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/11/20.
//

import Foundation

enum HTTPMethodType: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum HTTPContentType {
    case json
    case multipart(boundaryValue: String, data: [String: [Data]], uploadDataType: UploadDataType)
}

enum UploadDataType {
    case jpeg
    case png
    
    var contentType: String {
        switch self {
        case .jpeg:
            return "image/jpeg"
        case .png:
            return "image/png"
        }
    }
    
    var fileExtension: String {
        switch self {
        case .jpeg:
            return "jpg"
        case .png:
            return "png"
        }
    }
}

protocol Requestable {
    var path: String { get }
    var method: HTTPMethodType { get }
    var queryParameter: Encodable? { get }
    var headerParameter: [String: String] { get set }
    var bodyParameter: Encodable? { get }
    var contentType: HTTPContentType? { get }
}

extension Requestable {
    private func makeURL(networkConfig: NetworkConfiguration) throws -> URL {
        let baseURL = networkConfig.baseURL.absoluteString.last != "/" ? networkConfig.baseURL.absoluteString.appending("/") : networkConfig.baseURL.absoluteString
        let endpoint = baseURL.appending(path)
        guard var urlComponents = URLComponents(string: endpoint) else { throw NetworkServiceError.url }
        var queryItems: [URLQueryItem] = []
        queryItems += networkConfig.queryParameter.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        if let queryParameter {
            let query = try queryParameter.toQuery() ?? [:]
            queryItems += query.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
            urlComponents.queryItems = queryItems
        }
        guard let url = urlComponents.url else { throw NetworkServiceError.url }
        return url
    }
    
    func makeURLRequest(networkConfig: NetworkConfiguration) throws -> URLRequest {
        let url = try self.makeURL(networkConfig: networkConfig)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = networkConfig.header.merging(headerParameter, uniquingKeysWith: { $1 })
        if let bodyParameter {
            let body = try JSONEncoder().encode(bodyParameter)
            if let contentType {
                request = settingContentTypeHeader(urlrequest: request, contentType: contentType)
                request = try makeBody(request: request, bodyParameterData: body, contentType: contentType)
            } else {
                request.httpBody = body
            }
        }
        return request
    }
    
    func settingContentTypeHeader(urlrequest: URLRequest ,contentType: HTTPContentType) -> URLRequest {
        var cpRequest = urlrequest
        switch contentType {
        case .json:
            cpRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        case .multipart(let identifier, _, _):
            let contentType = "multipart/form-data; boundary=\(identifier)"
            cpRequest.addValue(contentType, forHTTPHeaderField: "Content-Type")
        }
        return cpRequest
    }
    
    private func makeBody(request: URLRequest, bodyParameterData: Data ,contentType: HTTPContentType) throws -> URLRequest {
        var cpRequest = request
        switch contentType {
        case .json:
            cpRequest.httpBody = bodyParameterData
        case .multipart(boundaryValue: let boundaryValue, data: let data, let uploadType):
            guard let bodyParameterDict = try JSONSerialization.jsonObject(with: bodyParameterData) as? [String: Any] else {
                return cpRequest
            }
            let strBodyDict = bodyParameterDict.mapValues { String(describing: $0) }
            cpRequest.httpBody = createMultipartBody(boundaryValue: boundaryValue, bodyParameterData: strBodyDict, datas: data, type: uploadType)
        }
        return cpRequest
    }
    
    private func createMultipartBody(boundaryValue: String, bodyParameterData: [String : String], datas: [String : [Data]], type: UploadDataType) -> Data {
        let convertData = NSMutableData()
        for parameter in bodyParameterData {
            convertData.appendString("\r\n--\(boundaryValue)\r\n")
            convertData.appendString("Content-Disposition: form-data; name=\"\(parameter.key)\"\r\n\r\n")
            convertData.appendString(parameter.value)
        }
        convertData.append(convertDatas(boundaryValue: boundaryValue, datas: datas, type: type))
        convertData.appendString("\r\n--\(boundaryValue)--\r\n")
        return convertData as Data
    }
    
    private func convertDatas(boundaryValue: String, datas: [String : [Data]], type: UploadDataType) -> Data {
        let convertData = NSMutableData()
        for data in datas {
            for detailData in data.value {
                convertData.appendString("\r\n--\(boundaryValue)\r\n")
                convertData.appendString("Content-Disposition: form-data; name=\"\(data.key)\"; filename=\"\(data.key)\(boundaryValue).\(type.fileExtension)\"\r\n")
                convertData.appendString("Content-Type: \(type.contentType)\r\n\r\n")
                convertData.append(detailData)
                convertData.appendString("\r\n")
            }
        }
        
        return convertData as Data
    }
}

protocol Responsable {
    associatedtype responseType
}

extension Encodable {
    func toQuery() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let json = try JSONSerialization.jsonObject(with: data)
        return json as? [String:Any]
    }
}

protocol Networable: Requestable, Responsable {}

struct EndPoint<T>: Networable where T: Decodable{
    
    typealias responseType = T
    
    let path: String
    let method: HTTPMethodType
    var contentType: HTTPContentType?
    let queryParameter: Encodable?
    var headerParameter: [String: String]
    var bodyParameter: Encodable?
    
    init(
        path: String,
        method: HTTPMethodType,
        contentType: HTTPContentType? = nil,
        query: Encodable? = nil,
        header: [String: String] = [:],
        bodyParameter: Encodable? = nil
    ) {
        self.path = path
        self.method = method
        self.queryParameter = query
        self.headerParameter = header
        self.bodyParameter = bodyParameter
        self.contentType = contentType
    }
}

extension NSMutableData {
    func appendString(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}

