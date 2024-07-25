//
//  MealDetailView.swift
//  fetchAssessment
//
//  Created by Tanmay Singla on 7/24/24.
//

import SwiftUI

struct MealDetailView: View {
    let mealID: String
    @StateObject private var viewModel = MealDetailViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            if let mealDetail = viewModel.mealDetail {
                
              HStack {
                VStack (alignment: .leading) {
                  Text(mealDetail.strMeal)
                    .font(.largeTitle)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true) 
                  
                  Text(mealDetail.strArea)
                    .font(.subheadline)
                }
                .padding()
                
                Spacer()
                
                if let imageUrl = mealDetail.strMealThumb, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(maxWidth: .infinity)
                        case .success(let image):
                            image
                              .resizable()
                              .scaledToFit()
                              .frame(width: 150, height: 150)
                              .cornerRadius(8)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                                .cornerRadius(8)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .padding()
                }
              }
                
                Text("Instructions")
                    .font(.headline)
                    .padding([.horizontal])
                
                ScrollView {
                    Text(mealDetail.strInstructions)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .shadow(radius: 1)
                }
                .padding(.horizontal)
              
                Text("Ingredients")
                    .font(.headline)
                    .padding([.top, .horizontal])
                
                List(mealDetail.ingredients.sorted(by: { $0.key < $1.key }), id: \.key) { ingredient, measure in
                    HStack {
                        Text(ingredient)
                        Spacer()
                        Text(measure)
                    }
                }
                .listStyle(.insetGrouped)
                .padding(.horizontal, -10)
                
              
            } else if viewModel.isLoading {
                ProgressView()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .navigationTitle("Meal Details")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.fetchMealDetail(id: mealID)
        }
    }
}

#Preview {
    MealDetailView(mealID: "53049")
}
