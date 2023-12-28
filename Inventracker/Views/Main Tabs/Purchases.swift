//
//  Purchases.swift
//  Inventracker
//
//  Created by Carlos Rafael Reyes Magadán on 4/6/23.
//

import SwiftUI

struct Purchases: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Slot.name, ascending: true)],
        animation: .default)
    private var slots: FetchedResults<Slot>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Purchase.date, ascending: false),
                          NSSortDescriptor(keyPath: \Purchase.slot, ascending: true)],
        animation: .default)
    private var purchases: FetchedResults<Purchase>
    
    @State private var showNewPurchaseView = false
    
    @State private var filterSelected = "All"
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(purchases, id: \.self) { purchase in
                    PurchaseOverview(purchase: purchase)
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Purchases")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showNewPurchaseView = true
                    } label: {
                        Label("New Purchase", systemImage: "plus")
                    }
                    .sheet(isPresented: $showNewPurchaseView) {
                        NewPurchase(slots: Array(slots), slot: slots.first!)
                    }
                    .disabled(slots.isEmpty)
                }
                
                ToolbarItem (placement: .automatic) {
                    Menu {
                        Button {
                            purchases.nsPredicate = nil
                            filterSelected = "All"
                        } label: {
                            Text("All")
                        }
                        ForEach(slots, id: \.self) { slot in
                            Button {
                                purchases.nsPredicate = NSPredicate(format: "slot.name == %@", slot.name!)
                                filterSelected = slot.name!
                            } label: {
                                Text("\(slot.name!) (\(slot.purchases?.count ?? -1))")
                            }
                        }
                    } label: {
                        Text(purchases.isEmpty ? "All" : filterSelected)
                    }
//                    .disabled(purchases.isEmpty)
                }
            }
        }
        .badge(purchases.count)
    }
    
    private func deleteItems(offsets: IndexSet) {
        
        var ingredients = [Ingredient]()
        
        withAnimation {
            offsets.map { purchases[$0] }.forEach {
                $0.slot?.ingredients?.forEach { ingredient in
                    ingredients.append(ingredient as! Ingredient)
                }
                deleteObject(object: $0, context: viewContext)
            }
        }
            
        ingredients.forEach {
            viewContext.refresh($0, mergeChanges: true)
        }
        
        ingredients.forEach { ingredient in
            viewContext.refresh(ingredient.recipe!, mergeChanges: true)
        }

        saveContext(context: viewContext)
    }
}
