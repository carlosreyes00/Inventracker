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
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(purchases, id: \.self) { purchase in
                    PurchaseInfo(purchase: purchase)
                }
            }
            .navigationTitle("Purchases")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        if slots.count == 0 {
                            return
                        }
                        showNewPurchaseView = true
                    } label: {
                        Label("New Purchase", systemImage: "plus")
                    }
                    .sheet(isPresented: $showNewPurchaseView) {
                        NewPurchase(slots: Array(slots), slot: slots.first!)
                    }
                }
                
                ToolbarItem (placement: .automatic) {
                    Menu {
                        Button {
                            purchases.nsPredicate = nil
                        } label: {
                            Text("All")
                        }
                        ForEach(slots, id: \.self) { slot in
                            Button {
                                purchases.nsPredicate = NSPredicate(format: "slot.name = %@", slot.name!)
                            } label: {
                                Text("\(slot.name!)")
                            }
                        }
                    } label: {
                        Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                    }
                }
            }
        }
        .badge(purchases.count)
    }
}

struct PurchaseInfo: View {
    let purchase: Purchase
    
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text((purchase.slot?.name!)!)
                    .bold()
                Text(purchase.date!, style: .date)
            }
            Spacer()
            VStack (alignment: .trailing) {
                Text(purchase.price, format: .currency(code: "USD"))
                let weight = Measurement(value: purchase.quantity, unit: UnitMass.grams)
                Text(weight, format: .measurement(width: .wide, usage: .asProvided))
            }
        }
    }
}

struct Purchases_Previews: PreviewProvider {
    static var previews: some View {
        Purchases()
    }
}
