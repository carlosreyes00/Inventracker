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
        List {
            if let ingredients = recipe.ingredients?.allObjects as? [Ingredient] {
                ForEach(ingredients, id: \.self) {
                    IngredientInfo(ingredient: $0)
                }
            }
        }
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

struct IngredientInfo: View {
    
    @ObservedObject var ingredient: Ingredient
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(ingredient.name ?? "no name")
                    .bold()
                HStack {
                    Text(ingredient.quantity, format: .number.decimalSeparator(strategy: .automatic))
                    Text(ingredient.unitOfMeasure.rawValue)
                }
            }
            Spacer()
            Text(ingredient.cost, format: .currency(code: "USD"))
        }
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
