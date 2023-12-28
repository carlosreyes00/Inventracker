//
//  IngredientOverview.swift
//  Inventracker
//
//  Created by Carlos Rafael Reyes Magadán on 6/13/23.
//

import SwiftUI

struct IngredientOverview: View {
    @ObservedObject var ingredient: Ingredient
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 0.5) {
                
                Text(ingredient.name ?? "no name")
                    .font(.title2)
                    .bold()
//                    .lineLimit(2)
                
                Text(String(format: "%.0f \(ingredient.unitOfMeasure.rawValue)", ingredient.quantity))
                
                Text(ingredient.cost, format: .currency(code: "USD"))
                    .font(.footnote)
                
                Group {
                    if ingredient.thereIsEnough {
                        HStack(spacing: 2) {
                            Text("It's enough")
                            Image(systemName: "checkmark")
                        }
                        .foregroundStyle(.green)
                        .bold()
                        
                    } else {
                        HStack(spacing: 2) {
                            Text(String(format: "Need %.0f more", ingredient.quantity))
                            Image(systemName: "xmark")
                        }
                        .foregroundStyle(.red)
                        .bold()
                    }
                }
                .font(.caption2)
                .fontWeight(.regular)
            }
            
            Spacer()
            
            Image(systemName: "ellipsis.circle.fill")
                .foregroundStyle(ingredient.thereIsEnough ? Color.green : Color.red)
            
            
        }
        .padding()
        .background {
            ingredient.thereIsEnough
            ? Color.green.opacity(0.1)
            : Color.red.opacity(0.1)
        }
        .cornerRadius(10)
    }
}

#Preview {
    let ingredient1 = Ingredient(context: PersistenceController.preview.container.viewContext)
    ingredient1.name = "Chocolate"
    ingredient1.quantity = 100
    ingredient1.unitOfMeasure = .grams
    ingredient1.slot = Slot(context: PersistenceController.preview.container.viewContext)
    ingredient1.slot?.name = ingredient1.name
    
    let ingredient2 = Ingredient(context: PersistenceController.preview.container.viewContext)
    ingredient2.name = "Vanilla"
    ingredient2.quantity = 0
    ingredient2.unitOfMeasure = .grams
    ingredient2.slot = Slot(context: PersistenceController.preview.container.viewContext)
    ingredient2.slot?.name = ingredient2.name

    return HStack {
        IngredientOverview(ingredient: ingredient1)
        IngredientOverview(ingredient: ingredient2)
    }
    .padding()
}
