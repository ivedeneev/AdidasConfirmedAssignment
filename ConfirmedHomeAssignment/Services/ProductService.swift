//
//  ProductService.swift
//  ConfirmedHomeAssignment
//
//  Created by Igor Vedeneev on 15.09.2021.
//

import Foundation
import Combine

protocol ProductService {
    func products() -> AnyPublisher<[Product], CError>
}

final class ProductServiceImpl: ProductService {
    
    private let requestBuilder: RequestBuilder
    private let networkClient: NetworkClient
    
    init(requestBuilder: RequestBuilder = .init(), networkClient: NetworkClient = NetworkClientImpl()) {
        self.requestBuilder = requestBuilder
        self.networkClient = networkClient
    }
    
    func products() -> AnyPublisher<[Product], CError> {
        let request = requestBuilder.urlRequest(for: Request.products)
        return networkClient.load(urlRequest: request)
    }
}
