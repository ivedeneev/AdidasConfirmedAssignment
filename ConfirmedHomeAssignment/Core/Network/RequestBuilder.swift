//
//  RequestBuilder.swift
//  ConfirmedHomeAssignment
//
//  Created by Igor Vedeneev on 15.09.2021.
//

import Foundation

final class RequestBuilder {
    func urlRequest(for endpoint: RequestType) -> URLRequest {
        guard var url = URL(string: endpoint.baseUrl) else {
            fatalError("Provided base url [\(endpoint.baseUrl)] has incorrect format") // there is no way if its ok to application logic and we should treat it like normal error.
        }
        
        url.appendPathComponent(endpoint.path)
        let request = NSMutableURLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let locale = Locale.current.identifier.replacingOccurrences(of: "_", with: "-") // e.g en_US > en-US to  make it work
        request.addValue(locale, forHTTPHeaderField: "Accept-Language")
        request.httpMethod = endpoint.httpMethod.rawValue
        
        switch endpoint.httpMethod {
        case .post:
            if let params = endpoint.params {
                request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            }
        case .get:
            break // In general we should encode get parameters here, but we dont need it here, so... :)
        }
        
        return request.copy() as! URLRequest
    }
}
