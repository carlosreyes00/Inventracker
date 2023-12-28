//
//  IngredientInfo.swift
//  Inventracker
//
//  Created by Carlos Rafael Reyes Magadán on 6/13/23.
//

import SwiftUI

struct IngredientOverview: View {
    @ObservedObject var ingredient: Ingredient
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(ingredient.name ?? "no name")
                    .bold()
                    .lineLimit(1)
                
                Text("Slot: \(ingredient.slot?.name ?? "no name")")
                    .lineLimit(1)
                
                HStack(spacing: 2) {
                    Text(ingredient.quantity, format: .number.decimalSeparator(strategy: .automatic))
                    Text(ingredient.unitOfMeasure.rawValue)
                }
                
                Text(ingredient.cost, format: .currency(code: "USD"))
                
                if !ingredient.thereIsEnough {
                    HStack(spacing: 2) {
                        Text("need")
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
