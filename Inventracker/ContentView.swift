//
//  ContentView.swift
//  Inventracker
//
//  Created by Carlos Rafael Reyes Magadán on 4/3/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Ingredient.name, ascending: true)],
        animation: .default)
    private var ingredients: FetchedResults<Ingredient>
    
    @State var showingNewIngredientView = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(ingredients, id: \.self) { ingredient in
                    NavigationLink {
                        Text(ingredient.name!)
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.green)
                    } label: {
                        Text(ingredient.name!)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Ingredients")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: {
                        showingNewIngredientView = true
                        //                            addItem()
                    }, label: {
                        Image(systemName: "plus")
                    })
                    .sheet(isPresented: $showingNewIngredientView) {
                        NewIngredient()
                    }
                }
            }
        }
    }
    
    //    private func addItem() {
    //        withAnimation {
    //            let newIngredient = Ingredient(context: viewContext)
    //            newIngredient.name = "name"
    //
    //            do {
    //                try viewContext.save()
    //            } catch {
    //                // Replace this implementation with code to handle the error appropriately.
    //                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
    //                let nsError = error as NSError
    //                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    //            }
    //        }
    //    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { ingredients[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
