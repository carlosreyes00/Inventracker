//
//  RecipeDistributionChart.swift
//  Inventracker
//
//  Created by Carlos Rafael Reyes Magadán on 6/19/23.
//

import SwiftUI
import Charts

struct RecipeDistributionChart: View {
    @ObservedObject var recipe: Recipe
    
    var body: some View {
            Chart((recipe.ingredients?.allObjects as? [Ingredient]) ?? [], id: \.self) {
                BarMark(
                    x: .value("Cost", $0.cost)
                )
                .foregroundStyle(by: .value("product", $0.name!))
            }
            .frame(height: 75)
    }
}

struct RecipeDistributionChart_Previews: PreviewProvider {
    
    static var previews: some View {
        let previewContext = PersistenceController.preview.container.viewContext
        deleteProductsToTesting(in: previewContext)
        
        let brownieRecipe = createRecipe(name: "Brownie", in: previewContext)
        addIngredient(name: "Eggs", quantity: 66, unitOfMeasure: .units, to: brownieRecipe, in: previewContext)
        addIngredient(name: "Sugar", quantity: 100, unitOfMeasure: .grams, to: brownieRecipe, in: previewContext)
        addIngredient(name: "Chocolate", quantity: 50, unitOfMeasure: .grams, to: brownieRecipe, in: previewContext)
        addIngredient(name: "Honey", quantity: 50, unitOfMeasure: .grams, to: brownieRecipe, in: previewContext)
        
        return RecipeDistributionChart(recipe: brownieRecipe)
    }
}
