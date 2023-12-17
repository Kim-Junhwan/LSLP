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
    case multipart(identifier: String, data: [String: [Data]], uploader: DataUploader)
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
                request = try makeBody(request: request, bodyParameterData: body, contentType: contentType)
            } else {
                request.httpBody = body
            }
        }
        
        return request
    }
    
    private func makeBody(request: URLRequest, bodyParameterData: Data ,contentType: HTTPContentType) throws -> URLRequest {
        var cpRequest = request
        switch contentType {
        case .json:
            cpRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            cpRequest.httpBody = bodyParameterData
        case .multipart(identifier: let identifier, data: let data, uploader: let uploader):
            cpRequest = uploader.settingHeader(identifier: identifier, request: cpRequest)
            guard let bodyParameterDict = try JSONSerialization.jsonObject(with: bodyParameterData) as? [String: Any] else {
                return cpRequest
            }
            let strBodyDict = bodyParameterDict.mapValues { String(describing: $0) }
            cpRequest.httpBody = uploader.createPostBody(identifier: identifier, bodyParameterData: strBodyDict, datas: data)
        }
        return cpRequest
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
