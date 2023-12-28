//
//  SlotOverview.swift
//  Inventracker
//
//  Created by Carlos Rafael Reyes Magadán on 6/17/23.
//

import SwiftUI

struct SlotOverview: View {
    @ObservedObject var slot: Slot
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text(slot.name ?? "no name")
                Spacer()
                HStack {
                    Text(slot.quantity, format: .number.decimalSeparator(strategy: .automatic))
                    Text(slot.unitOfMeasure.rawValue)
                }
            }
            Text("Ingredients: \(slot.ingredients?.count ?? -1)")
                .font(.callout)
        }
    }
}
