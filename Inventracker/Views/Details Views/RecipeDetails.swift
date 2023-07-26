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

struct RecipeDetails_Previews: PreviewProvider {
    static var previews: some View {
        let previewContext = PersistenceController.preview.container.viewContext
        deleteProductsToTesting(in: previewContext)
        
        let brownieRecipe = createRecipe(name: "Brownie", in: previewContext)
        
        addIngredient(name: "Eggs", quantity: 66, unitOfMeasure: .units, to: brownieRecipe, in: previewContext)
        addIngredient(name: "Sugar", quantity: 100, unitOfMeasure: .grams, to: brownieRecipe, in: previewContext)
        addIngredient(name: "Chocolate", quantity: 50, unitOfMeasure: .grams, to: brownieRecipe, in: previewContext)
        addIngredient(name: "Honey", quantity: 50, unitOfMeasure: .grams, to: brownieRecipe, in: previewContext)
        addIngredient(name: "Milk", quantity: 66, unitOfMeasure: .units, to: brownieRecipe, in: previewContext)
        addIngredient(name: "Chips", quantity: 100, unitOfMeasure: .grams, to: brownieRecipe, in: previewContext)
        addIngredient(name: "Vanilla", quantity: 50, unitOfMeasure: .grams, to: brownieRecipe, in: previewContext)
        addIngredient(name: "Ing 00", quantity: 50, unitOfMeasure: .grams, to: brownieRecipe, in: previewContext)
        addIngredient(name: "Ing 01", quantity: 50, unitOfMeasure: .grams, to: brownieRecipe, in: previewContext)
        addIngredient(name: "Ing 02", quantity: 50, unitOfMeasure: .grams, to: brownieRecipe, in: previewContext)
        addIngredient(name: "Ing 03", quantity: 50, unitOfMeasure: .grams, to: brownieRecipe, in: previewContext)
        addIngredient(name: "Ing 04", quantity: 50, unitOfMeasure: .grams, to: brownieRecipe, in: previewContext)
        addIngredient(name: "Ing 05", quantity: 50, unitOfMeasure: .grams, to: brownieRecipe, in: previewContext)
        addIngredient(name: "Ing 06", quantity: 50, unitOfMeasure: .grams, to: brownieRecipe, in: previewContext)
        
        return NavigationStack {
            RecipeDetails(recipe: brownieRecipe)
                .navigationTitle(brownieRecipe.name!)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
