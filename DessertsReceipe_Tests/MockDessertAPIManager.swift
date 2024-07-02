//
//  MockDessertAPIManager.swift
//  DessertsReceipe_Tests
//
//  Created by Amey Kanunje on 7/2/24.
//

import XCTest
@testable import Desserts_Receipe


//DessertMockAPIManager
class MockDessertAPIManager: APIManagerProtocol {
    var mockResponse: Result<Dessert, Error>?

    func request<T: Decodable>(
        modelType: T.Type,
        type: EndPointType,
        completion: @escaping (Result<T, DataError>) -> Void
    ) {
        // Force cast to the expected type
        if let response = mockResponse as? Result<T, DataError> {
            completion(response)
        } else {
            fatalError("Mock response not set for the specified model type")
        }
    }
}

