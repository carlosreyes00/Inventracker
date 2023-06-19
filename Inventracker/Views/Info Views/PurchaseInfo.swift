//
//  PurchaseInfo.swift
//  Inventracker
//
//  Created by Carlos Rafael Reyes Magadán on 6/19/23.
//

import SwiftUI

struct PurchaseInfo: View {
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
