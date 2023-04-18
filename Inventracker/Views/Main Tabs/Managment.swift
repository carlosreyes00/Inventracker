//
//  Managment.swift
//  Inventracker
//
//  Created by Carlos Rafael Reyes Magadán on 4/11/23.
//

import SwiftUI

struct Managment: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var ingredients: FetchedResults<Ingredient>
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var purchases: FetchedResults<Purchase>
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var recipes: FetchedResults<Recipe>
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var sales: FetchedResults<Sale>
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var slots: FetchedResults<Slot>
    
    var body: some View {
        List {
            Section {
                Text("ingredients: \(ingredients.count)")
                Text("purchases: \(purchases.count)")
                Text("recipes: \(recipes.count)")
                Text("sales: \(sales.count)")
                Text("slots: \(slots.count)")
                
                Button {
                    addProductsToTesting()
                } label: {
                    Text("Add products to testing")
                }
                
                Button(role: .destructive) {
                    deleteProductsToTesting()
                } label: {
                    Text("Delete everything")
                }
            } header: {
                Text("Control Center")
            }
            
            Section {
                ForEach(slots, id: \.self) { slot in
                    HStack {
                        Text(slot.name ?? "no name")
                        Spacer()
                        HStack {
                            Text(slot.availableQuantity, format: .number.decimalSeparator(strategy: .automatic))
                            Text(slot.unitOfMeasure.rawValue)
                        }
                    }
                }
            } header: {
                Text("Slots")
            }
        }
    }
}

struct Managment_Previews: PreviewProvider {
    static var previews: some View {
        Managment()
    }
}
