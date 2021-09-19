//
//  ProductService.swift
//  ConfirmedHomeAssignment
//
//  Created by Igor Vedeneev on 15.09.2021.
//

import Foundation
import Combine
import Resolver

protocol ProductService {
    func products() -> AnyPublisher<[Product], CError>
}

final class ProductServiceImpl: ProductService {
    
    @Injected private var requestBuilder: RequestBuilder
    @Injected private var networkClient: NetworkClient
    
    func products() -> AnyPublisher<[Product], CError> {
        let request = requestBuilder.urlRequest(for: Request.products)
        return networkClient.load(urlRequest: request)
    }
}
