//
//  MockAPIManager.swift
//  DessertsReceipe_Tests
//
//  Created by Amey Kanunje on 6/30/24.
//

import XCTest
@testable import Desserts_Receipe

//DessertDetailsMockAPIManager
class MockAPIManager: APIManagerProtocol {
    var responses: [String: Result<DessertDetails, DataError>] = [:]
    
    func setMockResponse(for endpoint: EndPointType, response: Result<DessertDetails, DataError>) {
        responses[endpoint.url?.absoluteString ?? ""] = response
    }
    
    func request<T: Decodable>(
        modelType: T.Type,
        type: EndPointType,
        completion: @escaping (Result<T, DataError>) -> Void
    ) {
        if let response = responses[type.url?.absoluteString ?? ""] as? Result<T, DataError> {
            completion(response)
        } else {
            completion(.failure(.invalidURL))
        }
    }
}


