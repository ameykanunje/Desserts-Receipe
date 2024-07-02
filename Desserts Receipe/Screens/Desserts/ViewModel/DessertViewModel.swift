//
//  DessertViewModel.swift
//  Desserts Receipe
//
//  Created by Amey Kanunje on 6/27/24.
//

import Foundation

final class DessertViewModel{
    
    var desserts : Dessert?
    var eventHandler : ((_ event : Event)-> Void)? //data binding
    private let apiManager: APIManagerProtocol

    init(apiManager: APIManagerProtocol = APIManager.shared) {
        self.apiManager = apiManager
    }
    
    func fetchDessertData(){
        self.eventHandler?(.loading)
        apiManager.request(
            modelType: Dessert.self,
            type: EndPointItems.Desserts) { response in
                self.eventHandler?(.stopLoading) //received the response
                switch response{
                case .success(let dessertsData):
                    self.desserts = dessertsData
                    self.eventHandler?(.dataLoading)
                    
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
            }
    }

}

extension DessertViewModel {
    enum Event{
        case loading
        case stopLoading
        case dataLoading
        case error(Error?)
    }
}
