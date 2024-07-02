//
//  Dessert.swift
//  Desserts Receipe
//
//  Created by Amey Kanunje on 6/27/24.
//
import Foundation

struct Dessert: Codable, Equatable {
    let meals: [Meals]
    
    enum CodingKeys: String, CodingKey {
        case meals
    }
}

struct Meals: Codable, Equatable {
    let mealName: String
    let mealImage: String
    let mealId: String
    
    enum CodingKeys: String, CodingKey {
        case mealName = "strMeal"
        case mealImage = "strMealThumb"
        case mealId = "idMeal"
    }
}

