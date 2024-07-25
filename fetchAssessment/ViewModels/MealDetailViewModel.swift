//
//  MealDetailViewModel.swift
//  fetchAssessment
//
//  Created by Tanmay Singla on 7/24/24.
//

import Foundation

@MainActor
class MealDetailViewModel: ObservableObject {
    @Published var mealDetail: MealDetail?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchMealDetail(id: String) async {
        isLoading = true
        do {
            mealDetail = try await MealService.shared.fetchMealDetail(by: id)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
