//
//  DessertDetailsViewModel.swift
//  Desserts Receipe
//
//  Created by Amey Kanunje on 6/29/24.
//

import Foundation
import SwiftUI
import Combine

class DessertDetailsViewModel: ObservableObject {
    @Published var mealDetails: MealDetails?
    @Published var isLoading: Bool = false
    @Published var error: Error?

    
    private let apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol = APIManager.shared) {
            self.apiManager = apiManager
        }

    func fetchDessertDetailsData(mealID: String) {
        self.isLoading = true
        self.error = nil
        
        apiManager.request(
            modelType: DessertDetails.self,
            type: EndPointItems.DessertsDetails(mealID: mealID)
        ) { [weak self] response in
            self?.isLoading = false
            
            switch response {
            case .success(let data):
                self?.mealDetails = data.meals.first
                
            case .failure(let error):
                print("Data Loading Error: \(error.localizedDescription)")
                self?.error = error
            }
            
        }
        
    }

    func getIngredients() -> [(String, String)] {
        return mealDetails?.ingredientsWithMeasures ?? []
    }

    enum Event {
        case dataLoading
        case error(Error?)
    }
}





//import Foundation
//import SwiftUI
//
//@Observable final class DessertDetailsViewModel{
//    var mealDetails : MealDetails?
//    var eventHandler : ((_ event : Event) -> Void)?
//    
//    func fetchDessertDetailsData(mealID: String){
//        self.eventHandler?(.loading)
//        APIManager.shared.request(
//            modelType: DessertDetails.self,
//            type: EndPointItems.DessertsDetails(mealID: mealID)) { response in
//                self.eventHandler?(.stopLoading) //received the response
//                
//                switch response{
//                case .success(let data):
//                    self.mealDetails = data.meals.first
//                    self.eventHandler?(.dataLoading)
//                    
//                case .failure(let error):
//                    print("Data Loading Error")
//                    self.eventHandler?(.error(error))
//                }
//            }
//    }
//    
//}
//
//extension DessertDetailsViewModel{
//    
//    enum Event{
//        case loading
//        case stopLoading
//        case dataLoading
//        case error(Error?)
//    }
//    
//}
