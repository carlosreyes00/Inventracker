//
//  Recipes.swift
//  Inventracker
//
//  Created by Carlos Rafael Reyes Magadán on 4/6/23.
//

import SwiftUI

struct Recipes: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.undoManager) private var undoManager
    
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
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        RecipeOverview(recipe: recipe)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(.inset)
            .navigationTitle("Recipes")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("Redo") {
                        undoManager!.redo()
                    }
                    .disabled(undoManager == nil || !(undoManager!.canRedo))
                    .foregroundColor(undoManager!.canRedo ? .accentColor : .red)
                }
                
                ToolbarItem(placement: .automatic) {
                    Button("Undo") {
                        undoManager!.undo()
                    }
                    .disabled(undoManager == nil || !(undoManager!.canUndo))
                    .foregroundColor(undoManager!.canUndo ? .accentColor : .red)
                }
                
                ToolbarItem (placement: .primaryAction) {
                    Button {
                        showingNewRecipe = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $showingNewRecipe) {
                        NewRecipe()
                    }
                }
                
                ToolbarItem {
                    EditButton()
                }
            }
            .onAppear {
                viewContext.undoManager = undoManager
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

//#Preview {
//    return Recipes().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
//}
