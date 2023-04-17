//
//  Recipes.swift
//  Inventracker
//
//  Created by Carlos Rafael Reyes Magadán on 4/6/23.
//

import SwiftUI

struct Recipes: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Recipe.name, ascending: true)],
        animation: .default)
    private var recipes: FetchedResults<Recipe>
    
    @State var showingNewRecipe = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(recipes, id: \.self) { recipe in
                    NavigationLink {
                        RecipeDetails(recipe: recipe)
                            .navigationTitle(recipe.name!)
                    } label: {
                        RecipeInfo(recipe: recipe)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(.inset)
            .navigationTitle("Recipes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                        .disabled(recipes.count == 0)
                }
                ToolbarItem {
                    Button {
                        showingNewRecipe = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $showingNewRecipe) {
                        NewRecipe()
                    }
                }
            }
        }
        .badge(recipes.count)
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { recipes[$0] }.forEach(viewContext.delete)
        }
        saveContext(context: viewContext)
    }
}

struct RecipeInfo: View {
    @ObservedObject var recipe: Recipe
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(recipe.name ?? "no name")
                .bold()
            Text("ingredients count: \(recipe.ingredients?.count ?? -1)")
        }
    }
}

struct Recipes_Previews: PreviewProvider {
    static var previews: some View {
        Recipes()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
