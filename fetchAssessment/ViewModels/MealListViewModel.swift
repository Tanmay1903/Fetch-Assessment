//
//  MealListViewModel.swift
//  fetchAssessment
//
//  Created by Tanmay Singla on 7/24/24.
//

import Foundation

@MainActor
class MealListViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchMeals() async {
        isLoading = true
        do {
            meals = try await MealService.shared.fetchDessertMeals()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
