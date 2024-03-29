//
//  SaleOverview.swift
//  Inventracker
//
//  Created by Carlos Rafael Reyes Magadán on 6/13/23.
//

import SwiftUI

struct SaleOverview: View {
    @ObservedObject var sale: Sale
    
    var body: some View {
        VStack (alignment: .center) {
            HStack (alignment: .center) {
                Text(sale.recipe?.name ?? "N/A")
                    .bold()
                Spacer()
                Text(sale.date ?? Date(), style: .date)
                    .fontWeight(.light)
            }
            
            HStack (alignment: .center) {
                Text("Cost: \(Text(sale.cost, format: .currency(code: "USD")))")
                Spacer()
                Text("Price: \(Text(sale.price, format: .currency(code: "USD")))")
            }
            Text("Profit: \(Text(sale.profit, format: .currency(code: "USD")))")
                .bold()
                .foregroundColor(sale.profit < 0 ? .red : .green)
        }
    }
}

struct SaleOverview_Previews: PreviewProvider {
    static var previews: some View {
        let sale = Sale(context: PersistenceController.preview.container.viewContext)
        sale.cost = 10
        sale.price = 25
        sale.recipe = nil
        sale.profit = sale.price - sale.cost
        
        sale.date = Date()
        
        return SaleOverview(sale: sale).padding()
    }
}
