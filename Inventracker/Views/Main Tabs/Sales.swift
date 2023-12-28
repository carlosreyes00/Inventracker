//
//  Sales.swift
//  Inventracker
//
//  Created by Carlos Rafael Reyes Magadán on 4/10/23.
//

import SwiftUI
import CoreData

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
                    SaleOverview(sale: sale)
                }
                ForEach(recipes, id: \.self) { recipe in
                    Text("\(recipe.name ?? "N/A") -> \(String(recipe.canBeSold))")
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
                        //                        NewSale(recipes: Array(recipes.filter({$0.isAvailable})), recipe: recipes.filter({$0.isAvailable}).first!)
                        NewSale(recipes: recipes, recipe: recipes.first(where: { $0.canBeSold })!)
                    }
                    .disabled(recipes.first(where: { $0.canBeSold }) == nil)
                }
            }
        }
        .badge(recipes.count)
    }
}
