//
//  RequestBuilderTests.swift
//  ConfirmedHomeAssignmentTests
//
//  Created by Igor Vedeneev on 15.09.2021.
//

import Foundation
import XCTest
@testable import ConfirmedHomeAssignment

class RequestBuilderTests: XCTestCase {
    
    let builder = RequestBuilder()
    
    func test_correctPath() {
        let endpoint = MockEndpoint(baseUrl:  "https://google.com/", httpMethod: .get, path: "search", params: nil)
        
        let request = builder.urlRequest(for: endpoint)
        XCTAssertEqual("\(endpoint.baseUrl)\(endpoint.path)", request.url?.absoluteString)
    }
    
    func test_bodyIgnoredAtGetRequests() {
        let endpoint = MockEndpoint(baseUrl:  "https://google.com/", httpMethod: .get, path: "search", params: ["a" : "a"])
        
        let request = builder.urlRequest(for: endpoint)
        XCTAssertEqual(request.httpBody,nil)
    }
    
    func test_bodyIsSetAtPostRequests() {
        let endpoint = MockEndpoint(baseUrl:  "https://google.com/", httpMethod: .post, path: "search", params: ["a" : "a"])
        
        let request = builder.urlRequest(for: endpoint)
        guard let params = endpoint.params as? [String : String] else {
            XCTFail()
            return
        }
        XCTAssertEqual(request.httpBody, try? JSONEncoder().encode(params))
    }
}

struct MockEndpoint: RequestType {
    let baseUrl: String
    let httpMethod: HTTPMethod
    let path: String
    let params: [String : Any]?
}
