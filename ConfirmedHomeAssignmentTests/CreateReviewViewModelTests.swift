//
//  CreateReviewViewModelTests.swift
//  ConfirmedHomeAssignmentTests
//
//  Created by Igor Vedeneev on 17.09.2021.
//

import Foundation
import XCTest
@testable import ConfirmedHomeAssignment
import Combine

class CreateReviewViewModelTests: XCTestCase {
    var viewModel: CreateReviewViewModel!
    var cancellable: Cancellable?
    
    override func setUp() {
        super.setUp()
        viewModel = CreateReviewViewModel(productId: "a", reviewService: MockReviewService())
    }
    
    func test_emptyMessageCausingError() {
        viewModel.sendReiew(text: "\n\n\n\n\n", rating: 0)
        let expectation = XCTestExpectation(description: "test_emptyMessageCausingError")
        
        cancellable = viewModel.$isErrorPresented.sink(receiveValue: { (isError) in
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 0.1)
    }
}

final class MockReviewService: ReviewsService {
    func reviews(for productId: String) -> AnyPublisher<[Review], CError> {
        Future { _ in }.eraseToAnyPublisher()
    }
    func postReview(productId: String, message: String, rating: Int) -> AnyPublisher<Review, CError> {
        Future { promise in
            let review = Review(productId: productId, locale: "en-US", rating: rating, text: message)
            promise(.success(review))
        }
        .eraseToAnyPublisher()
    }
}
