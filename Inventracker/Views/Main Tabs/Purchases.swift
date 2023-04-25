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
                    PurchaseInfo(purchase: purchase)
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
                    .disabled(slots.count == 0)
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
                                purchases.nsPredicate = NSPredicate(format: "slot.name = %@", slot.name!)
                                filterSelected = slot.name!
                            } label: {
                                Text("\(slot.name!) (\(slot.purchases?.count ?? -1))")
                            }
                        }
                    } label: {
                        Text(filterSelected)
//                        Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                    }
                }
            }
        }
        .badge(purchases.count)
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { purchases[$0] }.forEach(viewContext.delete)
        }
        saveContext(context: viewContext)
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
                HStack(spacing: 2) {
                    Text(purchase.availableQuantity, format: .number.decimalSeparator(strategy: .automatic))
                    Text("/")
                    Text(purchase.quantity, format: .number.decimalSeparator(strategy: .automatic))
                    Text(purchase.slot?.unitOfMeasure.rawValue ?? "-1")
                }
                .foregroundColor(purchase.isFullyUsed ? .red : .primary)
            }
        }
    }
}

struct Purchases_Previews: PreviewProvider {
    static var previews: some View {
        let previewContext = PersistenceController.preview.container.viewContext
        
        let newSlot = Slot(context: previewContext)
        newSlot.name = "Chocolate"
        newSlot.unitOfMeasure = .grams
        
        let newPurchase = Purchase(context: previewContext)
        newPurchase.date = Date()
        newPurchase.price = 9.99
        newPurchase.quantity = 40
        newPurchase.availableQuantity = 25
        newPurchase.isFullyUsed = false
        newPurchase.slot = newSlot
        
        return PurchaseInfo(purchase: newPurchase)
    }
}
