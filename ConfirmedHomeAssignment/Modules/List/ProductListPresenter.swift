//
//  ProductListPresenter.swift
//  ConfirmedHomeAssignment
//
//  Created by Igor Vedeneev on 16.09.2021.
//

import Foundation
import Combine

protocol ProductListPresenter {
    var view: ProductListView? { get set }
    
    func loadProducts()
    func searchProducts(query: String)
}

class ProductListPresenterImpl: ProductListPresenter {
    
    weak var view: ProductListView?
    private let productSerivce: ProductService
    private var cancellable: Cancellable?
    private var products = [Product]()
    
    init(productSerivce: ProductService = ProductServiceImpl()) {
        self.productSerivce = productSerivce
    }
    
    func loadProducts() {
        cancellable = productSerivce.products()
            .receive(on: RunLoop.main)
            .sink { [weak self] (completion) in
                switch completion {
                case .failure(let error):
                    self?.view?.didFailLoadProducts(error: error)
                default: break
                }
            } receiveValue: { [weak self] (products) in
                self?.products = products
                self?.view?.didloadProducts(products: products)
            }
    }
    
    func searchProducts(query: String) {
        if query.isEmpty {
            view?.didloadProducts(products: products)
            return
        }
        
        let result = products.filter { (product) -> Bool in
            product.name.localizedCaseInsensitiveContains(query) ||
                product.description.localizedCaseInsensitiveContains(query)
        }
        
        view?.didloadProducts(products: result)
    }
}
