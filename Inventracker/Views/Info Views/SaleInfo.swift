//
//  SaleInfo.swift
//  Inventracker
//
//  Created by Carlos Rafael Reyes Magadán on 6/13/23.
//

import SwiftUI

struct SaleInfo: View {
    @ObservedObject var sale: Sale
    
    var body: some View {
        VStack (alignment: .center) {
            HStack (alignment: .center) {
                Text(sale.recipe?.name ?? "N/A")
                    .bold()
                Spacer()
                Text(sale.date!, style: .date)
                    .fontWeight(.light)
            }
            
            HStack (alignment: .center) {
                HStack(spacing: 3) {
                    Text("Cost: ")
                    Text(sale.cost, format: .currency(code: "USD"))
                }
                Spacer()
                HStack(spacing: 3) {
                    Text("Price: ")
                    Text(sale.price, format: .currency(code: "USD"))
                }
            }
            
            HStack(spacing: 3) {
                Text("Profit: ")
                Text(sale.profit, format: .currency(code: "USD"))
            }
            .bold()
            .foregroundColor(.green)
        }
    }
}

struct SaleInfo_Previews: PreviewProvider {
    static var previews: some View {
        let sale = Sale(context: PersistenceController.preview.container.viewContext)
        sale.cost = 10
        sale.price = 25
        sale.recipe = nil
        sale.date = Date()
        
        return SaleInfo(sale: sale)
    }
}
