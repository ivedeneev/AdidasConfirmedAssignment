//
//  Review.swift
//  ConfirmedHomeAssignment
//
//  Created by Igor Vedeneev on 15.09.2021.
//

import Foundation

struct Review: Hashable, Identifiable, Decodable {
    var id: String { text }
    
    
    let productId: String
    let locale: String
    let rating: Int
    let text: String
}
