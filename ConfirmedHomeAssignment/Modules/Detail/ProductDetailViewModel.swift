//
//  ProductDetailViewModel.swift
//  ConfirmedHomeAssignment
//
//  Created by Igor Vedeneev on 16.09.2021.
//

import Foundation
import Combine
import Resolver

final class ProductDetailViewModel: ObservableObject {
    
    @Published private(set) var reviews: [Review] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error: String? = nil
    
    var productName: String {
        product.name
    }
    
    var productPrice: String {
        product.formattedPrice
    }
    
    var productDescription: String {
        product.description
    }
    
    var productImage: URL? {
        URL(string: product.imgUrl)
    }
    
    var productId: String {
        product.id
    }
    
    private let product: Product
    @Injected private var reviewsService: ReviewsService
    private var cancellables = Set<AnyCancellable>()
    
    init(product: Product) {
        self.product = product
    }
    
    func loadReviews() {
        isLoading = true
        error = nil
        reviewsService.reviews(for: product.id)
            .receive(on: RunLoop.main)
            .delay(for: 1, scheduler: RunLoop.main)
            .sink(receiveCompletion: { [weak self] (completion) in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // TODO: manage isloading and
                    self?.isLoading = false
                }
               
                switch completion {
                case .failure(let error):
                    self?.error = error.localizedDescription
                default:
                    break
                }
            }, receiveValue: { [weak self] (reviews) in
                self?.reviews = reviews
            })
            .store(in: &cancellables)
    }
}
