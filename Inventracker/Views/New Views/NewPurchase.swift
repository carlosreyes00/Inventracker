//
//  NewPurchase.swift
//  Inventracker
//
//  Created by Carlos Rafael Reyes Magadán on 4/10/23.
//

import SwiftUI

struct NewPurchase: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var date = Date()
    @State private var price = ""
    @State private var quantity = ""
    
    @State var slots: [Slot]
    
    @State var slot: Slot
    
    var body: some View {
        Form {
            Picker("Ingredient", selection: $slot) {
                ForEach(slots, id: \.self) { slot in
                    Text("\(slot.name!)").tag(slot.name!)
                }
            }
            
            DatePicker("Date", selection: $date)
            TextField("Price", text: $price)
            TextField("Quantity", text: $quantity)
            
            Button {
                if price.isEmpty || quantity.isEmpty {
                    return
                }
                
                let purchase = Purchase(context: viewContext)
                purchase.date = date
                purchase.price = Double(price) ?? -1
                purchase.slot = slot
                purchase.quantity = Double(quantity) ?? -1
                
                saveContext(context: viewContext)
                
                date = Date()
                price.removeAll()
                quantity.removeAll()
                
                dismiss()
            } label: {
                Label("Add Purchase", systemImage: "plus.circle")
            }
        }
    }
}

struct NewPurchase_Previews: PreviewProvider {
    static var previews: some View {
        NewPurchase(slots: [.init()], slot: .init())
    }
}
