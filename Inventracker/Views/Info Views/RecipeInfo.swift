//
//  RecipeInfo.swift
//  Inventracker
//
//  Created by Carlos Rafael Reyes Magadán on 6/13/23.
//

import SwiftUI

struct RecipeInfo: View {
    @ObservedObject var recipe: Recipe
    
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text(recipe.name ?? "no name")
                    .font(.title3)
                    .bold()
                Text("\(recipe.ingredients?.count ?? -1) ingredients")
                Text("Sales: \(recipe.sales?.count ?? -1)" )
            }
            
            Spacer()
            
            HStack {
                Text(recipe.cost, format: .currency(code: "USD"))
                Image(systemName: recipe.canBeSold
                      ? "checkmark.seal.fill"
                      : "xmark.seal.fill")
                .foregroundColor(recipe.canBeSold ? .green : .red)
                .bold()
            }
        }
    }
}

struct RecipeInfo_Previews: PreviewProvider {
    static var previews: some View {
        let recipe = Recipe(context: PersistenceController.preview.container.viewContext)
        recipe.name = "Recipe"
        
        return RecipeInfo(recipe: recipe).padding()
    }
}
