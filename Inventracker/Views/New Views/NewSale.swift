//
//  NewSale.swift
//  Inventracker
//
//  Created by Carlos Rafael Reyes Magadán on 4/24/23.
//

import SwiftUI

struct NewSale: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var date = Date()
    
    @State private var price = ""
    @State private var wrongPriceFormat = true
    
    var recipes: FetchedResults<Recipe>
    
//    @State var recipes: [Recipe]
    
    @State var recipe: Recipe
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Recipe", selection: $recipe) {
                    ForEach(recipes.filter { $0.canBeSold }, id: \.self) { recipe in
                        Text("\(recipe.name!)").tag(recipe.name!)
                    }
                }
                
                DatePicker("Date", selection: $date)
                
                DecimalTextField(name: "Price", decimal: $price, wrongDecimalFormat: $wrongPriceFormat)
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        dismiss()
                        addSale(date: date, recipe: recipe, price: Double(price)!)
                        recipe.sale()
                        date = Date()
                        price.removeAll()
                        print("it was sold successfully")
                    } label: {
                        Label("Add", systemImage: "plus.circle")
                            .labelStyle(.titleOnly)
                    }
                    .disabled(wrongPriceFormat)
                }
            }
        }
    }
}
