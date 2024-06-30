//
//  DessertDetails.swift
//  Desserts Companion
//
//  Created by csuftitan on 4/3/24.
//


import Foundation


struct DessertDetails : Decodable{
    var meals : [MealDetails]
}

struct MealDetails: Decodable {
    var mealId: String
    var mealName: String
    var mealInstructions: String
    var mealImage: String
    var ingredientsWithMeasures: [(String, String)] = []
    
    enum CodingKeys: String, CodingKey {
        case mealId = "idMeal"
        case mealName = "strMeal"
        case mealInstructions = "strInstructions"
        case mealImage = "strMealThumb"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        mealId = try container.decode(String.self, forKey: .mealId)
        mealName = try container.decode(String.self, forKey: .mealName)
        mealInstructions = try container.decode(String.self, forKey: .mealInstructions)
        mealImage = try container.decode(String.self, forKey: .mealImage)
        
        let additionalContainer = try decoder.container(keyedBy: AnyCodingKey.self)
        
        var ingredientsDict = [Int: String]()
        var measuresDict = [Int: String]()
        
        for key in additionalContainer.allKeys {
            if key.stringValue.starts(with: "strIngredient") {
                if let index = Int(key.stringValue.dropFirst("strIngredient".count)),
                   let ingredient = try additionalContainer.decodeIfPresent(String.self, forKey: key), !ingredient.isEmpty {
                    ingredientsDict[index] = ingredient
                }
            } else if key.stringValue.starts(with: "strMeasure") {
                if let index = Int(key.stringValue.dropFirst("strMeasure".count)),
                   let measure = try additionalContainer.decodeIfPresent(String.self, forKey: key), !measure.isEmpty {
                    measuresDict[index] = measure
                }
            }
        }
        
        //var tempIngredientsWithMeasures = [(String, String)]()
        
        for index in 1...max(ingredientsDict.keys.max() ?? 0, measuresDict.keys.max() ?? 0) {
            if let ingredient = ingredientsDict[index], let measure = measuresDict[index] {
                ingredientsWithMeasures.append((ingredient, measure))
            }
        }
        //self.ingredientsWithMeasures = tempIngredientsWithMeasures
    }
}

struct AnyCodingKey: CodingKey {
    var stringValue: String
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    var intValue: Int?
    init?(intValue: Int) {
        return nil
    }
}



//struct DessertDetails : Decodable{
//    var meals : [MealDetails]
//}
//
//struct MealDetails : Decodable{
//    var mealId : String
//    var mealName : String
//    var mealInstructions : String
//    var mealImage : String
//    var strIngredient1 : String?
//    var strIngredient2 : String?
//    var strIngredient3 : String?
//    var strIngredient4 : String?
//    var strIngredient5 : String?
//    var strIngredient6 : String?
//    var strIngredient7 : String?
//    var strIngredient8 : String?
//    var strIngredient9 : String?
//    var strIngredient10 : String?
//    var strIngredient11 : String?
//    var strIngredient12 : String?
//    var strIngredient13 : String?
//    var strIngredient14 : String?
//    var strIngredient15 : String?
//    var strIngredient16 : String?
//    var strIngredient17 : String?
//    var strIngredient18 : String?
//    var strIngredient19 : String?
//    var strIngredient20 : String?
//    var strMeasure1 : String?
//    var strMeasure2 : String?
//    var strMeasure3 : String?
//    var strMeasure4 : String?
//    var strMeasure5 : String?
//    var strMeasure6 : String?
//    var strMeasure7 : String?
//    var strMeasure8 : String?
//    var strMeasure9 : String?
//    var strMeasure10 : String?
//    var strMeasure11 : String?
//    var strMeasure12 : String?
//    var strMeasure13 : String?
//    var strMeasure14 : String?
//    var strMeasure15 : String?
//    var strMeasure16 : String?
//    var strMeasure17 : String?
//    var strMeasure18 : String?
//    var strMeasure19 : String?
//    var strMeasure20 : String?
//    
//}
//
////Filtering out optional values
//extension MealDetails {
//    var ingredientsWithMeasures: [(String, String)] {
//            let ingredients = [
//                strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5,
//                strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10,
//                strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15,
//                strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
//            ].compactMap { $0 }
//            
//            let measures = [
//                strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5,
//                strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10,
//                strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15,
//                strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
//            ].compactMap { $0 }
//            
//            return Array(zip(ingredients, measures))
//        }
//}


