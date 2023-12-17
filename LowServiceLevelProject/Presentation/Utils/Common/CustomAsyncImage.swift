//
//  CustomAsyncImage.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/17.
//

import SwiftUI

struct CustomAsyncImage<Content: View, Placeholder: View>: View {
    
    @State var image: UIImage?
    
    var path: String?
    let content: (Image) -> Content
    let placeHolder: () -> Placeholder
    private let dataTransferSerivice = DataTransferService(networkService: DefaultNetworkService(config: APINetworkConfigs.registerConfig), defaultResponseHandler: CommonResponseErrorHandler())
    
    var body: some View {
        if let image {
            content(Image(uiImage: image))
        } else {
            placeHolder()
                .task {
                    getImage(path: path)
                }
        }
    }
    
    private func getImage(path: String?) {
        guard let path else { image = nil
            return
        }
        do {
            let imageRequest = try ImageRequest(path: path)
            DefaultNetworkService(config: APINetworkConfigs.registerConfig).request(endPoint: imageRequest) { result in
                switch result {
                case .success(let success):
                    guard let imageData = success else {
                        image = nil
                        return
                    }
                    image = UIImage(data: imageData)
                case .failure(_):
                    image = nil
                }
            }
        } catch {
            image = nil
        }
        
    }
}

struct ImageRequest: Requestable {
    var path: String
    var method: HTTPMethodType = .GET
    var queryParameter: Encodable?
    var headerParameter: [String : String]
    var bodyParameter: Encodable? = nil
    var contentType: HTTPContentType? = nil
    
    init(path: String, queryParameter: Encodable? = nil) throws {
        self.path = path
        self.queryParameter = queryParameter
        self.headerParameter = ["Authorization": try DefaultTokenRepository.readTokenAtKeyChain(tokenCase: .accessToken)]
    }
    
}
