//
//  NewIngredient.swift
//  Inventracker
//
//  Created by Carlos Rafael Reyes Magadán on 4/3/23.
//

import SwiftUI

struct NewIngredient: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State var name: String = ""
    @State var quantity: String = ""
    @State var unitOfMeasure: UnitOfMeasure = .grams
    
    @State var recipe: Recipe
    
    @State var wrongNumberFormat = false
    
    var body: some View {
        Form {
            TextField("New Ingredient", text: $name)
            
            TextField("Quantity", text: .init(get: {
                quantity
            }, set: { value in
                quantity = value
                
                if let firstPointIndex = value.firstIndex(of: ".") {
                    if value[firstPointIndex...].dropFirst().contains(".") {
                        quantity.removeLast()
                        return
                    }
                }
                
                if Double(value) != nil {
                    wrongNumberFormat = false
                } else {
                    wrongNumberFormat = true
                }
            }))
            .keyboardType(.decimalPad)
            
            Picker("Unit of Measure", selection: $unitOfMeasure) {
                ForEach(UnitOfMeasure.allCases, id: \.self) {
                    Text("\($0.rawValue)")
                }
            }
            .pickerStyle(.menu)
            
            Section {
                Button {
                    if name.isEmpty || quantity.isEmpty {
                        return
                    }
                    
                    let ingredient = Ingredient(context: viewContext)
                    ingredient.name = name
                    ingredient.quantity = Double(quantity) ?? -1.00
                    ingredient.unitOfMeasure = unitOfMeasure
                    ingredient.recipe = recipe
                    
                    let slot = Slot(context: viewContext)
                    slot.name = name
                    
                    saveContext(context: viewContext)
                    
                    name.removeAll()
                    quantity.removeAll()
                    
                    dismiss()
                } label: {
                    Label("Add to \(recipe.name!)", systemImage: "plus.circle")
                        .labelStyle(.titleOnly)
                }
                .disabled(wrongNumberFormat)
            } footer: {
                Text("Press to add a new ingredient to \(recipe.name!)")
            }
            
            Section {
                Text(String(Double(quantity) ?? 11111))
                    .foregroundColor(wrongNumberFormat ? .red : .green)
                    .font(.largeTitle)
            }
        }
    }
}



struct NewIngredient_Previews: PreviewProvider {
    static var previews: some View {
        let newRecipe = Recipe(context: PersistenceController.preview.container.viewContext)
        newRecipe.name = "Preview Recipe"
        
        return NewIngredient(recipe: newRecipe)
    }
}
