//
//  Meal.swift
//  fetchAssessment
//
//  Created by Tanmay Singla on 7/24/24.
//

import Foundation

struct Meal: Identifiable, Codable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String?
    
    var id: String { idMeal }
}

struct MealListResponse: Codable {
    let meals: [Meal]
}

struct MealDetail: Codable {
    let idMeal: String
    let strMeal: String
    let strInstructions: String
    let strMealThumb: String?
    let strArea: String
    
    // Adding optional ingredients and measurements
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
    
    // Computed property to get non-empty ingredients and measurements
    var ingredients: [String: String] {
        var result = [String: String]()
        for i in 1...20 {
            if let ingredient = self["strIngredient\(i)"], !ingredient.isEmpty,
               let measure = self["strMeasure\(i)"], !measure.isEmpty {
                result[ingredient] = measure
            }
        }
        return result
    }
    
    subscript(key: String) -> String? {
        return Mirror(reflecting: self).children.first { $0.label == key }?.value as? String
    }
}

struct MealDetailResponse: Codable {
    let meals: [MealDetail]
}
