//
//  ReviewsService.swift
//  ConfirmedHomeAssignment
//
//  Created by Igor Vedeneev on 16.09.2021.
//

import Foundation
import Combine
import Resolver

protocol ReviewsService {
    func reviews(for productId: String) -> AnyPublisher<[Review], CError>
    func postReview(productId: String, message: String, rating: Int) -> AnyPublisher<Review, CError>
}

final class ReviewsServiceImpl: ReviewsService {
    
    @Injected private var requestBuilder: RequestBuilder
    @Injected var networkClient: NetworkClient
    
    func reviews(for productId: String) -> AnyPublisher<[Review], CError> {
        let request = requestBuilder.urlRequest(for: Request.reviews(productId: productId))
        return networkClient.load(urlRequest: request)
    }
    
    func postReview(productId: String, message: String, rating: Int) -> AnyPublisher<Review, CError> {
        let trimmedText = message.trimmingCharacters(in: .whitespacesAndNewlines)
        let requestModel = Request.sendReview(productId: productId, text: trimmedText, rating: rating)
        let request = requestBuilder.urlRequest(for: requestModel)
        return networkClient.load(urlRequest: request)
    }
}
