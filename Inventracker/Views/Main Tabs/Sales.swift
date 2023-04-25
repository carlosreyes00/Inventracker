//
//  Sales.swift
//  Inventracker
//
//  Created by Carlos Rafael Reyes Magadán on 4/10/23.
//

import SwiftUI

struct Sales: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Sale.date, ascending: true)],
        animation: .default)
    private var sales: FetchedResults<Sale>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Recipe.name, ascending: true)],
        animation: .default)
    private var recipes: FetchedResults<Recipe>
    
    @State private var showingNewSale = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sales, id: \.self) { sale in
                    SaleInfo(sale: sale)
                }
            }
            .navigationTitle("Sales")
            .toolbar {
                ToolbarItem {
                    Button {
                        showingNewSale = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $showingNewSale) {
                        NewSale(recipes: Array(recipes.filter({$0.isAvailable})), recipe: recipes.filter({$0.isAvailable}).first!)
                    }
                    .disabled(recipes.filter({$0.isAvailable}).count == 0)
                } 
            }
        }
        .badge(sales.count)
    }
}

struct SaleInfo: View {
    let sale: Sale
    
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
                    Text("Price: ")
                    Text(sale.price, format: .currency(code: "USD"))
                }
                Spacer()
                HStack(spacing: 3) {
                    Text("Cost: ")
                    Text(sale.cost, format: .currency(code: "USD"))
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

struct SalesInfo_Previews: PreviewProvider {
    static var previews: some View {
        let previewContext = PersistenceController.preview.container.viewContext
        
        let newRecipe = Recipe(context: previewContext)
        newRecipe.name = "Brownie P"
        
        let newSale = Sale(context: previewContext)
        newSale.date = Date()
        newSale.recipe = newRecipe
        newSale.cost = 8.50
        newSale.price = 25
        newSale.profit = newSale.price - newSale.cost
        
        return SaleInfo(sale: newSale)
    }
}

