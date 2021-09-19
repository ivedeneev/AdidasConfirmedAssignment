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
    case custom(String)
    
    var localizedDescription: String? {
        switch self {
        case .custom(let reason):
            return reason
        default:
            return "Error!!!" //TODO: proper error descriptions
        }
    }
}

