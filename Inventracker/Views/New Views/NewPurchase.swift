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
    
    @State private var wrongPriceFormat = true
    @State private var wrongQuantityFormat = true
    
    @State var slots: [Slot]
    
    @State var slot: Slot
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Ingredient", selection: $slot) {
                    ForEach(slots, id: \.self) { slot in
                        Text("\(slot.name!)").tag(slot.name!)
                    }
                }
                
                DatePicker("Date", selection: $date)
                
                DecimalTextField(name: "Price", decimal: $price, wrongDecimalFormat: $wrongPriceFormat)
                DecimalTextField(name: "Quantity", decimal: $quantity, wrongDecimalFormat: $wrongQuantityFormat)
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        addPurchase(date: date, price: Double(price)!, quantity: Double(quantity)!, slot: slot, in: viewContext)
                        dismiss()
                    } label: {
                        Label("Add", systemImage: "plus.circle")
                            .labelStyle(.titleOnly)
                    }
                    .disabled(wrongPriceFormat || wrongQuantityFormat)
                }
            }
        }
    }
}
