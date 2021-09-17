//
//  Request.swift
//  ConfirmedHomeAssignment
//
//  Created by Igor Vedeneev on 15.09.2021.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol RequestType {
    var baseUrl: String { get }
    var httpMethod: HTTPMethod { get }
    var path: String { get }
    var params: [String : Any]? { get }
}

enum Request: RequestType {
    
    case products
    case reviews(productId: String)
    case sendReview(productId: String, text: String, rating: Int)
    
    var baseUrl: String {
        switch self {
        case .products:
            return "http://localhost:3001"
        default:
            return "http://localhost:3002"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .sendReview:
            return .post
        default:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .products:
            return "product"
        case .reviews(let productId), .sendReview(let productId, _, _):
            return "reviews/\(productId)"
        }
    }
    
    var params: [String : Any]? {
        switch self {
        case .sendReview(_, let text, let rating):
            return [
              "rating": rating,
              "text": text,
            ] as [String : Any]
        default:
            return nil
        }
    }
}
