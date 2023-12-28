//
//  PurchaseOverview.swift
//  Inventracker
//
//  Created by Carlos Rafael Reyes Magadán on 6/19/23.
//

import SwiftUI

struct PurchaseOverview: View {
    @ObservedObject var purchase: Purchase
    
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text(purchase.slot?.name ?? "N/A")
                    .bold()
                Text(purchase.date ?? Date(), style: .date)
            }
            Spacer()
            VStack (alignment: .trailing) {
                Text(purchase.price, format: .currency(code: "USD"))
                Text(String(format: "%.2f / %.2f \(purchase.slot?.unitOfMeasure.rawValue ?? "-1")", purchase.availableQuantity, purchase.quantity))
                    .foregroundColor(purchase.isFullyUsed ? .red : .primary)
            }
        }
    }
}
