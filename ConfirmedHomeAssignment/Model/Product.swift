//
//  Product.swift
//  ConfirmedHomeAssignment
//
//  Created by Igor Vedeneev on 15.09.2021.
//

import Foundation

struct Product: Hashable, Identifiable, Decodable {
    let id: String
    let name: String
    let description: String
    let price: Int
    let currency: String
    let imgUrl: String
    
    var formattedPrice: String {
        "\(currency)\(price)"
    }
}
