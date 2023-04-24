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
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                if let ingredients = recipe.ingredients?.allObjects as? [Ingredient] {
                    ForEach(ingredients, id: \.self) {
                        IngredientInfo(ingredient: $0)
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
            }
        }
    }
}

struct IngredientInfo: View {
    
    @ObservedObject var ingredient: Ingredient
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(ingredient.name ?? "no name")
                    .bold()
                    .lineLimit(1)
                
                HStack(spacing: 2) {
                    Text(ingredient.quantity, format: .number.decimalSeparator(strategy: .automatic))
                    Text(ingredient.unitOfMeasure.rawValue)
                }
                
                Text(ingredient.cost, format: .currency(code: "USD"))
                
                if !ingredient.thereIsEnough {
                    HStack(spacing: 2) {
                        Text("you need")
                        Text(ingredient.neededQuantity, format: .number.decimalSeparator(strategy: .automatic))
                        Text("more")
                    }
                }
            }
            Spacer()
        }
        .padding()
        .background {
            ingredient.thereIsEnough
            ? Color.mint.opacity(0.2)
            : Color.red.opacity(0.2)
        }
        .cornerRadius(10)
    }
}

struct RecipeDetails_Previews: PreviewProvider {
    static var previews: some View {
        
        let previewContext = PersistenceController.preview.container.viewContext
        
        let previewRecipe = Recipe(context: previewContext)
        previewRecipe.name = "Preview Recipe"
        
        var set: NSSet = NSSet()
        
        for index in 1...25 {
            let ingredient = Ingredient(context: previewContext)
            ingredient.name = "Ingredient No. \(index)"
            ingredient.quantity = Double(index) * 100
            set = set.adding(ingredient) as NSSet
        }
        previewRecipe.ingredients? = set
        
        return RecipeDetails(recipe: previewRecipe)
    }
}
