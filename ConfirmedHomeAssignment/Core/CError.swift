//
//  CError.swift
//  ConfirmedHomeAssignment
//
//  Created by Igor Vedeneev on 15.09.2021.
//

import Foundation

enum CError: Error {
    case noConnection
    case http
    case decoding(DecodingError)
    case unknown
    
    var localizedDescription: String? {
        "Error!!!" //TODO: proper error descriptions
    }
}

