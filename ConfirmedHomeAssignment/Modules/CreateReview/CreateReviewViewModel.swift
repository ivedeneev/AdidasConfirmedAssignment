//
//  CreateReviewViewModel.swift
//  ConfirmedHomeAssignment
//
//  Created by Igor Vedeneev on 17.09.2021.
//

import Combine
import Foundation
import SwiftUI

final class CreateReviewViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var sentReview: Review?
    @Published var isErrorPresented = false
    private(set) var error: String?

    private let reviewService: ReviewsService
    private let productId: String
    private var cancellables = Set<AnyCancellable>()
    
    init(productId: String, reviewService: ReviewsService = ReviewsServiceImpl()) {
        self.productId = productId
        self.reviewService = reviewService
        
        $isErrorPresented.filter { !$0 }.sink { [weak self] _ in
            self?.error = nil
        }.store(in: &cancellables)
    }
    
    func sendReiew(text: String, rating: Int) {
        guard !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            error = NSLocalizedString("empty_review_message", comment: "")
            isErrorPresented = true
            return
        }
        
        isLoading = true
        reviewService.postReview(productId: productId, message: text, rating: rating)
            .receive(on: RunLoop.main)
            .delay(for: 0.3, scheduler: RunLoop.main)
            .sink { [weak self] (completion) in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.error = "Error"
                    self?.isErrorPresented = true
                default:
                    break
                }
            } receiveValue: { [weak self] (review) in
                self?.sentReview = review
            }
            .store(in: &cancellables)

    }
}
