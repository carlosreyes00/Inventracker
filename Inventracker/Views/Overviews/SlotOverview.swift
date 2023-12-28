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
                Text(String(format: "%.2f \(slot.unitOfMeasure.rawValue)", slot.quantity))
            }
            Text("Ingredients: \(slot.ingredients?.count ?? -1)")
                .font(.callout)
        }
    }
}
