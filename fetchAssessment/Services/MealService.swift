//
//  MealService.swift
//  fetchAssessment
//
//  Created by Tanmay Singla on 7/24/24.
//

import Foundation

class MealService {
    static let shared = MealService()
    
    private let baseURL = "https://themealdb.com/api/json/v1/1/"
    
    func fetchDessertMeals() async throws -> [Meal] {
        guard let url = URL(string: baseURL + "filter.php?c=Dessert") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let mealListResponse = try JSONDecoder().decode(MealListResponse.self, from: data)
        return mealListResponse.meals.sorted { $0.strMeal < $1.strMeal }
    }
    
    func fetchMealDetail(by id: String) async throws -> MealDetail {
        guard let url = URL(string: baseURL + "lookup.php?i=\(id)") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let mealDetailResponse = try JSONDecoder().decode(MealDetailResponse.self, from: data)
        guard let mealDetail = mealDetailResponse.meals.first else {
            throw URLError(.cannotFindHost)
        }
        return mealDetail
    }
}
