//
//  Sales.swift
//  Inventracker
//
//  Created by Carlos Rafael Reyes Magadán on 4/10/23.
//

import SwiftUI

struct Sales: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Sale.date, ascending: true)],
        animation: .default)
    private var sales: FetchedResults<Sale>
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sales, id: \.self) { sale in
                    SaleInfo(sale: sale)
                }
            }
            .navigationTitle("Sales")
        }
        .badge(sales.count)
    }
}

struct SaleInfo: View {
    let sale: Sale

    var body: some View {
        VStack (alignment: .leading) {
            Text(sale.date?.description ?? "it no has name :(")
        }
    }
}

struct Sales_Previews: PreviewProvider {
    static var previews: some View {
        Sales()
    }
}

