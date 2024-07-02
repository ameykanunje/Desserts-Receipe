//
//  DessertViewModelUnitTests.swift
//  DessertsReceipe_Tests
//
//  Created by Amey Kanunje on 7/2/24.
//

import XCTest
@testable import Desserts_Receipe

final class DessertViewModelUnitTests: XCTestCase {
    
    var viewModel: DessertViewModel!
    var mockAPIManager: MockDessertAPIManager!
    
    override func setUp() {
        super.setUp()
        mockAPIManager = MockDessertAPIManager()
        viewModel = DessertViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        mockAPIManager = nil
        super.tearDown()
    }
    
    func test_fetchDessertData_onSuccess() {
        // Given
        let jsonData = """
        {
            "meals": [
                {
                    "strMeal": "Apam balik",
                    "strMealThumb": "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
                    "idMeal": "53049"
                }
            ]
        }
        """.data(using: .utf8)!
        
        // Decode JSON data
        let decoder = JSONDecoder()
        let expectedDessert = try! decoder.decode(Dessert.self, from: jsonData)
        
        // Mock API Response
        mockAPIManager.mockResponse = .success(expectedDessert)
        
        // When
        viewModel.fetchDessertData()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.viewModel.desserts, expectedDessert)
        }
    }
    
    
    
    
}
