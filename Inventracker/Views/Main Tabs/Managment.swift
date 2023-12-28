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
                Text("Ingredients: \(ingredients.count)")
                Text("Purchases: \(purchases.count)")
                Text("Recipes: \(recipes.count)")
                Text("Sales: \(sales.count)")
                Text("Slots: \(slots.count)")
            } header: {
                Text("Entities")
            }
            
            Section {
                Button {
                    addProductsToTesting()
                } label: {
                    Text("Add products to testing")
                        .foregroundColor(.blue)
                }
                
                Button(role: .destructive) {
                    deleteProductsToTesting()
                } label: {
                    Text("Delete everything")
                }
                
                Button {
                    deleteProductsToTesting()
                    addProductsToTesting()
                } label: {
                    Text("Refresh")
                }
            } header: {
                Text("Control Center")
            }
            
            Section {
                ForEach(slots, id: \.self) { slot in
                    SlotOverview(slot: slot)
                }
            } header: {
                Text("Slots")
            }
        }
    }
}
