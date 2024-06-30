//
//  Dessert.swift
//  Desserts Companion
//
//  Created by csuftitan on 4/3/24.
//
import Foundation

// MARK: - Dessert
struct Dessert: Codable {
    let meals: [Meals]
    
    enum CodingKeys: String, CodingKey {
        case meals
    }
}

// MARK: - Meal
struct Meals: Codable {
    let mealName: String
    let mealImage: String
    let mealId: String
    
    enum CodingKeys: String, CodingKey {
        case mealName = "strMeal"
        case mealImage = "strMealThumb"
        case mealId = "idMeal"
    }
}






//struct Dessert : Decodable{
//    var meals : [Meals]
//}
//
//struct Meals : Decodable{
//    var mealName : String
//    var mealImage : String
//    var mealId : String
//}

