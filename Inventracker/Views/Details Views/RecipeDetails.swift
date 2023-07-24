//
//  RecipeDetails.swift
//  Inventracker
//
//  Created by Carlos Rafael Reyes Magadán on 4/4/23.
//

import SwiftUI

struct RecipeDetails: View {
    @ObservedObject var recipe: Recipe
    
    @State private var showNewIngredientView = false
    
    @State private var showDistributionPrice = false
    
    var body: some View {
        VStack (alignment: .center) {
            if showDistributionPrice {
                RecipeDistributionChart(recipe: recipe)
                    .padding()
            }
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                    if let ingredients = recipe.ingredients?.allObjects as? [Ingredient] {
                        ForEach(ingredients, id: \.self) { ingredient in
                            IngredientInfo(ingredient: ingredient)
                        }
                    }
                }
                .padding(.horizontal)
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            showNewIngredientView = true
                        } label: {
                            Label("New Ingredient", systemImage: "plus")
                        }
                        .sheet(isPresented: $showNewIngredientView) {
                            NewIngredient(recipe: recipe)
                        }
                    }
                    ToolbarItem {
                        Button {
                            withAnimation (.spring(dampingFraction: 0.5)) {
                                showDistributionPrice.toggle()
                            }
                        } label: {
                            Label("Show Distribution Chart", systemImage: "chart.bar")
                        }
                    }
                }
            }
        }
    }
}
