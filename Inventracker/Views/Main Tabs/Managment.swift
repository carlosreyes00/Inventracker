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
    
    @State private var isShowingDialogToDelete = false
    
    var body: some View {
        List {
            Section {
                Text("ingredients: \(ingredients.count)")
                Text("purchases: \(purchases.count)")
                Text("recipes: \(recipes.count)")
                Text("sales: \(sales.count)")
                Text("slots: \(slots.count)")
                
                Button(role: .destructive) {
                    isShowingDialogToDelete = true
                } label: {
                    Text("Delete everything")
                }
                .confirmationDialog("Delete Data Completely", isPresented: $isShowingDialogToDelete, actions: {
                    Button("Confirm", role: .destructive) {
                        deleteObjects(objects: ingredients, context: viewContext)
                        deleteObjects(objects: purchases, context: viewContext)
                        deleteObjects(objects: recipes, context: viewContext)
                        deleteObjects(objects: sales, context: viewContext)
                        deleteObjects(objects: slots, context: viewContext)
                        
                        saveContext(context: viewContext)
                    }
                    
                    Button("Cancel", role: .cancel) {
                        isShowingDialogToDelete = false
                    }
                }, message: {
                    Text("Are you sure to delete the data completely?")
                })
                
            } header: {
                Text("Control Center")
            }
            
            Section {
                ForEach(slots, id: \.self) { slot in
                    HStack {
                        Text(slot.name ?? "no name :(")
                        Spacer()
                        let availableQuantity = Measurement(value: slot.availableQuantity, unit: UnitMass.grams)
                        Text(availableQuantity, format: .measurement(width: .wide, usage: .asProvided))
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
