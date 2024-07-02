//
//  DessertsDetailsViewModelUnitTests.swift
//  DessertsReceipe_Tests
//
//  Created by Amey Kanunje on 6/30/24.
//

import XCTest
@testable import Desserts_Receipe

final class DessertsDetailsViewModelUnitTests: XCTestCase {
    
    var viewModel: DessertDetailsViewModel!
    var mockAPIManager: MockAPIManager!
    
    override func setUp() {
        super.setUp()
        mockAPIManager = MockAPIManager()
        viewModel = DessertDetailsViewModel(apiManager: mockAPIManager)
    }
    
    override func tearDown() {
        viewModel = nil
        mockAPIManager = nil
        super.tearDown()
    }
    
    func test_decodingDessertDetails_successful() {
        // Example JSON data
        let jsonData = """
            {
                "meals": [
                    {
                        "idMeal": "12345",
                        "strMeal": "Chocolate Cake",
                        "strInstructions": "Mix ingredients and bake.",
                        "strMealThumb": "https://www.example.com/chocolate_cake.jpg",
                        "strIngredient1": "Flour",
                        "strMeasure1": "2 cups",
                        "strIngredient2": "Sugar",
                        "strMeasure2": "1 cup",
                        "strIngredient3": "Cocoa powder",
                        "strMeasure3": "1/2 cup"
                    }
                ]
            }
            """.data(using: .utf8)!
        
        do {
            let dessertDetails = try JSONDecoder().decode(DessertDetails.self, from: jsonData)
            print(dessertDetails)
            XCTAssertNotNil(dessertDetails, "Decoding failed")
        } catch {
            XCTFail("Failed to decode JSON: \(error)")
        }
    }
    
    
    func test_fetchDessertDetailsData_setsMealDetailsOnSuccess() {
        // Given
        let mealID = "12345"
        
        // Create mock JSON data for the MealDetails object
        let jsonData = """
        {
            "meals": [
                {
                    "idMeal": "\(mealID)",
                    "strMeal": "Chocolate Cake",
                    "strInstructions": "Mix ingredients and bake.",
                    "strMealThumb": "https://www.example.com/chocolate_cake.jpg"
                }
            ]
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let mockDessertDetails: DessertDetails
        do {
            mockDessertDetails = try decoder.decode(DessertDetails.self, from: jsonData)
        } catch {
            XCTFail("Failed to decode mock JSON data into DessertDetails")
            return
        }
        
        // Setup mock API response
        mockAPIManager.setMockResponse(for: EndPointItems.DessertsDetails(mealID: mealID), response: .success(mockDessertDetails))
        
        // When
        viewModel.fetchDessertDetailsData(mealID: mealID)
        
        // Simulate delay for asynchronous operation
        let expectation = XCTestExpectation(description: "Wait for fetch to complete")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.viewModel.mealDetails?.mealId, mealID, "mealDetails should be set to the fetched data")
            XCTAssertEqual(self.viewModel.mealDetails?.mealName, "Chocolate Cake", "mealDetails should have correct mealName")
            XCTAssertEqual(self.viewModel.mealDetails?.mealImage, "https://www.example.com/chocolate_cake.jpg", "mealDetails should have correct mealImage")
            XCTAssertEqual(self.viewModel.mealDetails?.mealInstructions, "Mix ingredients and bake.", "mealDetails should have correct mealInstructions")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    
    func test_fetchDessertDetailsData_isLoadingFalseAfterAPICall() {
        // Given
        let mealID = "52893"
        let mockAPIManager = MockAPIManager()
        //let viewModel = ViewModel(apiManager: mockAPIManager)
        
        // Set a mock response for the endpoint
        let mockError = DataError.networkError("Mock Error")
        mockAPIManager.setMockResponse(for: EndPointItems.DessertsDetails(mealID: mealID), response: .failure(mockError))
        
        // When
        viewModel.fetchDessertDetailsData(mealID: mealID)
        
        // Then
        XCTAssertFalse(viewModel.isLoading, "isLoading should be true when fetchDessertDetailsData is called")
    }
    
    
    func test_mealDetails_shouldBeEmpty(){
        //Given
        
        //When
        let vm = DessertDetailsViewModel()
        //Then
        XCTAssertNil(vm.mealDetails)
    }
    
    func test_isLoading_shouldBeFalse(){
        //Given
        
        //When
        let vm = DessertDetailsViewModel()
        
        //Then
        XCTAssertFalse(vm.isLoading, "isLoading should be false when DessertDetailsViewModel is initialized")
    }
    
    func test_error_shouldBeNil(){
        //Given
        
        //When
        let vm = DessertDetailsViewModel()
        //Then
        XCTAssertNil(vm.error)
    }
    
    
}
