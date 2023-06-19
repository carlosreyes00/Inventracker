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
    
    @State var wrongQuantityFormat = false
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("New Ingredient", text: $name)
                
                DecimalTextField(name: "Quantity", decimal: $quantity, wrongDecimalFormat: $wrongQuantityFormat)
                
                Section {
                    Picker("Unit of Measure", selection: $unitOfMeasure) {
                        ForEach(UnitOfMeasure.allCases, id: \.self) {
                            Text("\($0.rawValue)")
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        addIngredient(name: name, quantity: Double(quantity)!, unitOfMeasure: unitOfMeasure, to: recipe, in: viewContext)
                        dismiss()
                    } label: {
                        Label("Add to \(recipe.name!)", systemImage: "plus.circle")
                            .labelStyle(.titleOnly)
                    }
                    .disabled(name.isEmpty || wrongQuantityFormat)
                }
            }
        }
    }
}

struct DecimalTextField: View {
    var name: String
    @Binding var decimal: String
    @Binding var wrongDecimalFormat: Bool
    
    var body: some View {
        TextField(name, text: .init(get: {
            decimal
        }, set: { value in
            decimal = value
            
            if let firstPointIndex = value.firstIndex(of: ".") {
                if value[firstPointIndex...].dropFirst().contains(".") {
                    decimal.removeLast()
                }
            }
            
            if Double(decimal) != nil {
                wrongDecimalFormat = false
            } else {
                wrongDecimalFormat = true
            }
        }))
        .keyboardType(.decimalPad)
    }
}
