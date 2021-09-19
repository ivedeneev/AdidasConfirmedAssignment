//
//  HttpClient.swift
//  ConfirmedHomeAssignment
//
//  Created by Igor Vedeneev on 15.09.2021.
//

import Foundation
import Combine

/// Responsible for network requests
protocol NetworkClient {
    func load<T:Decodable>(urlRequest: URLRequest, decoder: JSONDecoder) -> AnyPublisher<T, CError>
}

extension NetworkClient {
    func load<T:Decodable>(urlRequest: URLRequest) -> AnyPublisher<T, CError> {
        load(urlRequest: urlRequest, decoder: JSONDecoder())
    }
}

final class NetworkClientImpl: NetworkClient {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func load<T:Decodable>(urlRequest: URLRequest, decoder: JSONDecoder) -> AnyPublisher<T, CError> {
        session
            .dataTaskPublisher(for: urlRequest)
            .tryMap { output -> Data in
                let acceptableCodes: Set<Int> = [200, 201]
                guard let response = output.response as? HTTPURLResponse,
                      acceptableCodes.contains(response.statusCode)
                else {
                    throw CError.http
                }

                return output.data
            }
            .decode(type: T.self, decoder: decoder)
            .mapError { (error) -> CError in
                switch error {
                case let decodingError as DecodingError:
                    return .decoding(decodingError)
                case let error as NSError:
                    return .custom(error.localizedDescription)
                default:
                    return .unknown
                }
            }
            .subscribe(on: DispatchQueue.global(qos: .utility))
            .eraseToAnyPublisher()
    }
}
